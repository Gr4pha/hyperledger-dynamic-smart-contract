#! /bin/bash

cd ~/dynscpaper/dynsc-hlf

echo ""
echo "→ Printing stats of the machine..."
echo "  >>> 'lsb_release -a'"
lsb_release -a
echo "  >>> 'uname -a'"
uname -a
echo "← Done."


echo ""
# echo ""
# echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
# ./scripts/bench.sh 2
# echo "################################################################################"
# sleep 2
# echo ""
# echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
# ./scripts/bench.sh 4
# echo "################################################################################"
# sleep 2
# echo ""
# echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
# ./scripts/bench.sh 8
# echo "################################################################################"
# sleep 2
# echo ""
# echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
# ./scripts/bench.sh 10
# echo "################################################################################"
# sleep 2
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 20
echo "################################################################################"
sleep 3
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 30
echo "################################################################################"
sleep 3
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 40
echo "################################################################################"
sleep 3
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 50
echo "################################################################################"
sleep 5
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 100
echo "################################################################################"
sleep 10
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 200
echo "################################################################################"
sleep 10
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 500
echo "################################################################################"
sleep 30
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 1000
echo "################################################################################"
sleep 30
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 2000
echo "################################################################################"
sleep 60
echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
./scripts/bench.sh 5000
echo "################################################################################"
# # sleep 60
# # echo ""
# # echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
# # ./scripts/bench.sh 10000
# # echo "################################################################################"




