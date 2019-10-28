#! 	/bin/bash

export N="$1"
export PEER0="peer0.org1.hurley.lab"
export ORDERER="orderer.hurley.lab"
export CHANNEL="ch1"
export SC_NAME="dynsc"
export HURLEY_UP="npm run env:restart"
export HURLEY_DOWN="npm run env:clean"
export HURLEY_DEPLOY="npm run cc:start $SC_NAME"
export DOCKER_EXEC="docker exec -it $PEER0"
export HLF_BIN_PATH="/home/user/hyperledger-fabric-network/fabric-binaries/1.4.0/bin"
export PRJCT_PATH="/home/user/dynscpaper/dynsc-hlf"
export DYNCST_NAME="CST001"
export TX_CREATE_DYNCST="hurl invoke $SC_NAME $(echo $SC_NAME)_create $DYNCST_NAME"
export SC_SET_FCT="$(echo $SC_NAME)_set"
# export SC_SET_ARGS="'{\"name\":\"$DYNCST_NAME\",\"cst\":123}'"
export SC_SET_ARGS="$DYNCST_NAME 123"
export SC_GET_FCT="$(echo $SC_NAME)_get"
# export SC_GET_ARGS="'{}'"
export SC_GET_ARGS="$DYNCST_NAME"
export TX_SET_DYNCST="hurl invoke $SC_NAME $SC_SET_FCT $SC_SET_ARGS"
export TX_GET_DYNCST="hurl invoke $SC_NAME $SC_GET_FCT $SC_GET_ARGS"
export RM_BLOCKS="rm -f *.block && rm -f *.block.json"

cd $PRJCT_PATH



echo "→ Starting hurley..."
export Tbeg=$(python3 -c "import time; print(int(time.time()))")
# echo $Tbeg
# $HURLEY_UP 2>/dev/null >> logs/hurley.log
# $HURLEY_UP 2>&1 > /dev/null
$HURLEY_UP 2>/dev/null > /dev/null
echo "← Done."
sleep 1



echo ""
echo "→ Deploying smart contract with Hurley..."
# $HURLEY_DEPLOY 2>/dev/null >> logs/hurley.log
# $HURLEY_DEPLOY 2>&1 > /dev/null
$HURLEY_DEPLOY 2>/dev/null > /dev/null
echo "← Done."
sleep 1

export N0=$($DOCKER_FETCH_CHANNEL_INFO | grep "Blockchain info:" | cut -d ' ' -f 3 | jq .height)
# echo "Blocks: $N0"

echo ""
echo "→ Starting benchmark of $N tx..."
export Tstart=$(python3 -c "import time; print(int(time.time()))")
# $TX_CREATE_DYNCST >> logs/hurley.log
# $TX_CREATE_DYNCST 2>&1 > /dev/null
$TX_CREATE_DYNCST 2>/dev/null > /dev/null
for ((i=0;i<$N;i++))
do
	# # v1:
	# $TX_SET_DYNCST >> logs/hurley.log
	# $TX_GET_DYNCST >> logs/hurley.log
	# $TX_SET_DYNCST 2>&1 > /dev/null
	# $TX_GET_DYNCST 2>&1 > /dev/null
	$TX_SET_DYNCST 2>/dev/null > /dev/null
	$TX_GET_DYNCST 2>/dev/null > /dev/null
	# # v2;
	# $TX_SET_DYNCST 2>&1 >> logs/hurley.log &
	# $TX_GET_DYNCST 2>&1 >> logs/hurley.log &
done
# v2:
# wait
export Tdiff=$(echo $Tstart | python3 -c "import sys, time; print(int(time.time()) - int([l for l in sys.stdin][0]))")
echo "← Done."



echo ""
echo "→ Computing data..."
export DOCKER_FETCH_CHANNEL_INFO="$DOCKER_EXEC peer channel getinfo -c $CHANNEL -o $ORDERER"
# echo $DOCKER_FETCH_CHANNEL_INFO
export N_BLOCK=$($DOCKER_FETCH_CHANNEL_INFO | grep "Blockchain info:" | cut -d ' ' -f 3 | jq .height)
# echo "$N_BLOCK blocks"
export NB_TX_IN_BLOCKS=""
for ((i=$N0;i<$N_BLOCK;i++))
do
	export BLOCK_NAME="$(echo $i).block"
	# echo $BLOCK_NAME
	export DOCKER_FETCH_BLOCK="$DOCKER_EXEC peer channel fetch $i $BLOCK_NAME -c $CHANNEL -o $ORDERER"
	# $DOCKER_FETCH_BLOCK >> logs/docker.log
	# $DOCKER_FETCH_BLOCK 2>&1 > /dev/null
	$DOCKER_FETCH_BLOCK 2>/dev/null > /dev/null
	export DOCKER_GET_BLOCK="docker cp $PEER0:/opt/gopath/src/github.com/hyperledger/fabric/$BLOCK_NAME $BLOCK_NAME"
	# $DOCKER_GET_BLOCK >> logs/docker.log
	# $DOCKER_GET_BLOCK 2>&1 > /dev/null
	$DOCKER_GET_BLOCK 2>/dev/null > /dev/null
	cd $HLF_BIN_PATH
	export BLOCK_TO_JSON="./configtxlator proto_decode --type=common.Block --input=$(echo $PRJCT_PATH)/$(echo $BLOCK_NAME) --output=$(echo $PRJCT_PATH)/$(echo $BLOCK_NAME).json"
	$BLOCK_TO_JSON 2>/dev/null > /dev/null
	cd $PRJCT_PATH
	export NB_TX_IN_BLOCK=$(jq '.data.data | length' $(echo $PRJCT_PATH)/$(echo $BLOCK_NAME).json)
	# echo $NB_TX_IN_BLOCK
	export NB_TX_IN_BLOCKS="$(echo $NB_TX_IN_BLOCKS),$(echo $NB_TX_IN_BLOCK)"
done
# echo "Blocks: $N_BLOCK - $N0"
export N_BLOCK=$(($N_BLOCK - $N0))
# echo "Blocks: $N_BLOCK"
export TOTAL_BLOCKS_SIZE="$(du -h $PRJCT_PATH/*.block | cut -d 'K' -f 1 | cut -d ',' -f 1 | python3 -c 'import sys; print(sum(int(l) for l in sys.stdin))')"
# echo "$TOTAL_BLOCKS_SIZE KB"
# echo $NB_TX_IN_BLOCKS
export AVG_BLOCKS_SIZE=$(echo $TOTAL_BLOCKS_SIZE $N_BLOCK | python3 -c 'import sys; IN = [l for l in sys.stdin][0].strip("\n").split(" "); r = int(IN[0]) / int(IN[1]); print( str( int(r*100)/100 ) )')
# echo AVG Block Size $AVG_BLOCKS_SIZE KB
export AVG_TX_PER_BLOCK=$(echo $NB_TX_IN_BLOCKS | python3 -c 'import statistics as stat, sys; print(stat.mean([int(x) for x in str([l for l in sys.stdin][0]).split(",") if x != ""]))')
# echo "AvgTx: $AVG_TX_PER_BLOCK"
export TOTAL_TX=$(echo $NB_TX_IN_BLOCKS | python3 -c 'import sys; IN = [int(x) for x in [l for l in sys.stdin][0].strip("\n").split(",") if x != ""]; print(sum(IN));')
# echo tot tx $TOTAL_TX
$RM_BLOCKS 2>/dev/null > /dev/null

export T=$(echo $Tbeg | python3 -c "import sys, time; print(int(time.time()) - int([l for l in sys.stdin][0]))")
export TdiffMin=$(echo $Tdiff | python3 -c 'import sys; print(int(int([l for l in sys.stdin][0]) / 60))')

echo "----------------------------------------------------"
echo "[IN]"
echo "Nb tx: $N"
echo "----------------------------------------------------"
echo "[OUT]"
echo "Nb Block: $N_BLOCK"
echo "Avg tx / Block: $AVG_TX_PER_BLOCK"
echo "Avg Block size (KB): $AVG_BLOCKS_SIZE"
echo "Nb tx: $TOTAL_TX"
echo "Time spent (s): $Tdiff"
echo "Time spent (min): $TdiffMin"
echo "----------------------------------------------------"
echo "Total time spent (s): $T"
echo "----------------------------------------------------"
echo "$N;$N_BLOCK;$TOTAL_TX;$Tdiff;$TdiffMin;$AVG_BLOCKS_SIZE;$T" >> logs/results.log
echo "← Done."



echo ""
echo "→ Stoping hurley..."
# $HURLEY_DOWN 2>/dev/null >> logs/hurley.log
# $HURLEY_DOWN 2>&1 > /dev/null
$HURLEY_DOWN 2>/dev/null > /dev/null
echo "← Done."
sleep 1

