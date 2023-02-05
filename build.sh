# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone --depth=1 https://github.com/parikk/android_device_samsung_m20lte.git -b 13-evox device/samsung/m20lte

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
export BUILD_USERNAME=parikk
export BUILD_HOSTNAME=parikk-build
export EVO_BUILD_TYPE=OFFICIAL
lunch evolution_m20lte-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
mka evolution -j16  > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end
