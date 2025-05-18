rm -rf .repo/local_manifests/

#repo init
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 15.0 -g default,-mips,-darwin,-notdefault
echo "=================="
echo "Repo init success"
echo "=================="

#local_manifest
git clone https://github.com/blazey66/local_manifest_clo.git -b a15 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

#Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# ksun
cd ~/kernel/xiaomi/mithorium-4.19/kernel
curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next-susfs/kernel/setup.sh" | bash -s next-susfs
cd ../../../..

# Export
export BUILD_USERNAME=Blazey66
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

#build
brunch Mi439_4_19
