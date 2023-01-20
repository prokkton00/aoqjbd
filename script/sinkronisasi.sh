env:
# ENCRYPTED
  RCLONECONFIG_DRIVE: "ENCRYPTED[f89eabaffabe0a4cb90994359c1cb083df61f18b7d00ff097897d66e997f836c34d7a80cb63d34c098bb0c99071409bb]"
  TG_TOKEN: "ENCRYPTED[b2eea57b24307457b508a2b76e266a5268a67d463497876f152b00363b8f99f1de9540278c75c75e2b80625b44343a41]"
  TG_CHAT_ID: "ENCRYPTED[62be02d46f4ef818097a1c592e9fec0572df72cd996b3cd37925779116d422d1d0cd913ffe7ad81ae742f672c3a60320]"
  CREDENTIALS: "ENCRYPTED[44144db425362c943a1ba31df3791fc770639dd61b56fdebf3d442f3c6576fd675717c53c9d250238f882071b91a917c]"
  EMAIL: "ENCRYPTED[184f5c0f3b3cbdb18319810fe79e73389416ade8cf00474ad82dce8b9d1223407efda16342e1218f88106fd211076bdb]"

# FLAG
  WORKDIR: "/tmp"
  CIRRUS_CLONE_DEPTH: "1"

task:
  name: "Setting Up, Syncing, Building and Uploading"
  timeout_in: 120m
  container:
    image: chalkzone/build:22.04
    cpu: 8
    memory: 32G

  Memuat-ccache_background_script:
     - ./script/memuat_ccache.sh
     
  Repo-pribadi_script:
     - git config --global user.name "parikk"
     - git config --global user.email "$EMAIL"
     - echo "$CREDENTIALS" > ~/.git-credentials
     - git config --global credential.helper store --file=~/.git-credentials

  Sinkronisasi_script:
     - ./script/sinkronisasi.sh
     
  Build-rom_script:
     - ./script/membangun.sh
     
  Ccache-info_script:
     - set -e
     - export CCACHE_DIR=$WORKDIR/ccache
     - ccache -s
     
  Upload-build_script:
     - ./script/mengemas.sh
     
