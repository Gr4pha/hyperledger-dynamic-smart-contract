#! /bin/bash

export GANACHE="ganache-cli -b 15 --defaultBalanceEther 100000 --gasLimit 0x2FEFD800000"
export TRUFFLE="truffle deploy --reset"
export BENCH="truffle exec scripts/bench.js"
export N="$1"

cd ~/dynscpaper/dynsc-eth

echo "→ Starting ganache-cli..."
$GANACHE >> logs/ganache.log &
export PID="$!"
echo "Ganache-cli PID: $PID"
echo "← Done."
sleep 5

echo ""
echo "→ Deploying smart contract with Truffle..."
$TRUFFLE 2>/dev/null >> logs/truffle.log
echo "← Done."
sleep 2

echo ""
echo "→ Starting benchmark of $N tx..."
# $BENCH $N 2>/dev/null >> logs/bench.log
$BENCH $N 2>>logs/results.log 1>> logs/bench.log
echo "← Done."
sleep 2

echo "→ Killing Ganache..."
kill -SIGTERM $PID
echo "← Done."
sleep 3

