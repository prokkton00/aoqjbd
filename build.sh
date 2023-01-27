# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/TheDoctor12/manifest.git -b topaz
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
./rom-build.sh lmi -t user -z  > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end
