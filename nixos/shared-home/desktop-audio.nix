{ config, pkgs, ...}:
{
  services.pipewire = {
        extraConfig.pipewire."loopback" = {
      "context.modules" = [
      	{ 
	  name = "libpipewire-module-loopback";
  	  args = {
      	    "node.name" = "loopback";
      	    "node.description" = "loopback";
            "capture.props" = {
              "target.object" = "output.jonas-low-pass-filter";
            };
            "playback.props" = {
              "target.object" = "alsa_output.usb-Generic_USB2.0_Device_20170726905959-00.2.analog-stereo";
            };
          };
        }
      ];
    };
    extraConfig.pipewire."lowpass" = {
      "context.modules" = [
        {
	  name = "libpipewire-module-filter-chain";
	  args = {
	    "node.description" = "Low-Pass Filter Sink";
	    "node.name" = "jonas-low-pass-filter";
	    "media.name" = "lp-sink";
	    "playback.props" = {
	      "node.autoconnect" = false;
	    };

	    "filter.graph" = {
	      nodes = [
	        {
		  type = "builtin";
		  name = "lowpass-l";
		  label = "bq_lowpass";
		  control = {
		    "Freq" = 50;
		  };
		}
		{
		  type = "builtin";
		  name = "lowpass-r";
		  label = "bq_lowpass";
		  control = {
		    "Freq" = 50;
		  };
		}
	      ];
	      inputs = [ "lowpass-l:In" "lowpass-r:In" ];
	      outputs = [ "lowpass-l:Out" "lowpass-r:Out" ];
	    };
	  };
	}
      ];
    };
    extraConfig.pipewire."combinestream" = {
      "context.modules" = [
        {
	  name = "libpipewire-module-combine-stream";
          args = {
            "combine.mode" = "sink";
            "node.name" = "jonascombinesink";
            "node.description" = "Combined sink that pushes to three devices";
            "combine.props" = {
              "audio.position" = [ "FL" "FR" ];
            };
            "stream.props" = {
              "stream.dont-remix" = true;
            };
            "stream.rules" = [
              {
	        matches = [
                  {
		    "media.class" = "Audio/Sink";
                    "node.name" = "alsa_output.usb-1532_Razer_BlackShark_V2_Pro_2.4_O001000007-00.analog-stereo";
                  }
		];
                actions = {
		  create-stream = {
                    "audio.position" = [ "FL" "FR" ];
        	    "combine.audio.position" = [ "FL" "FR" ];
                  };
	        };
	      }
              {
	        matches = [
                  {
		    "media.class" = "Audio/Sink";
                    "node.name" = "alsa_output.pci-0000_0d_00.4.analog-stereo";
                  }
	        ];
                actions = {
		  create-stream = {
                    "audio.position" = [ "FL" "FR" ];
                    "combine.audio.position" = [ "FL" "FR" ];
                  };
	        };
	      }
              {
	        matches = [
                  {
		    "media.class" = "Stream/Input/Audio";
         	    "node.name" = "input.jonas-low-pass-filter";
                  }
		];
                actions = {
		  create-stream = {
                    "audio.position" = [ "FL" "FR" ];
                    "combine.audio.position" = [ "FL" "FR" ];
                  };
	        };
	      }
            ];
          };
        }
      ];
    };
  };
}
