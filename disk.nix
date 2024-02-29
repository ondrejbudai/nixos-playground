{
  disko.devices = {
    disk = {
      vdb = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            mbr = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            boot = {
              name = "boot";
              size = "1G";
              type = "BC13C2FF-59E6-4262-A352-B275FD6F7172";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              type = "6264D520-3FB9-423F-8AB8-7A0A8E3D3562";
              content = {
                type = "btrfs";
                subvolumes = {
                  "/root" = {
                    mountOptions = [ "compress=zstd:1" ];
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd:1" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd:1" ];
                    mountpoint = "/nix";
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=1G"
        ];
      };
    };
  };
}
