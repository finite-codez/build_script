rm -rf .repo/local_manifests/

#repo init
repo init --depth=1 --no-repo-verify -u https://github.com/finite-codez/fetch.git -b lineage-22.2 -g default,-mips,-darwin,-notdefault
echo "=================="
echo "Repo init success"
echo "=================="

#local_manifest
git clone https://github.com/AsTechpro20/local_manifests_blossom.git -b lineage-22.1 .repo/local_manifests
echo "============================
echo "Local manifest clone success"
echo "============================"

#Sync
/opt/crave/resync.sh
echo "================="
echo " RESYNC STARTED! "
echo "================="

# Export
export BUILD_USERNAME=finitecode
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

#build
echo "====== Starting build, you may pray ======="
brunch blossom user
