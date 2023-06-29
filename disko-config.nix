{ disk, memory, ... }: {
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = disk;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "512MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              name = "luks";
              start = "512MiB";
              end = "100%";
              content = {
                type = "luks";
                name = "crypted";
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            }
          ];
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          # LVs are created in alphabetic order for some reason
          # Prefixing them with a letter like this ensures desired creation order
          a_swap = {
            size = memory;
            content = {
              type = "swap";
            };
          };
          z_persist = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition
              subvolumes =
                let mountOptions = [ "compress=zstd" "noatime" "nodiratime" "discard" ];
                in
                {
                  "/nix" = {
                    inherit mountOptions;
                  };
                  "/persist" = {
                    inherit mountOptions;
                  };
                  "/log" = {
                    mountpoint = "/var/log";
                    inherit mountOptions;
                  };
                };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "mode=755"
        ];
      };
    };
  };
}
