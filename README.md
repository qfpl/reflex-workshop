# YOW! Lambda Jam Reflex Workshop

## Getting set up

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Download the OVA file from [here](https://hydra.qfpl.io/job/reflex-workshop/reflex-workshop/reflex-workshop-vm/latest/download/1) (Right click and select "Save As")
  - The file is around 1.6 GB in size, so you probably don't want to download this from your mobile phone
- Import the OVA into VirtualBox
  - The menu option should be something like: File > Import Appliance
- Start the VM
- From within the VM
  - Open a terminal
  - Checkout this repository

    ```
    git clone https://github.com/qfpl/reflex-workshop
    ```

## Updating the repository

To do this:

- Start the VM
- From within the VM
  - Open a terminal
    ```
    cd reflex-workshop
    git pull
    ```

## Editors and tools

The VirtualBox appliance comes with these text editors
  - `emacs`
  - `gedit` 
  - `vim`
and these Haskell tools:
  - `cabal-install`
  - `ghcid`
  - `ghc-mod`
  - `hasktags`
  - `hindent`
  - `hlint`
  - `hoogle`
  - `stylish-haskell`

If you want to configure `vim` or `emacs` to your liking before the workshop, go for it.

## Running the workshop 

The workshop is run from within the VM

- Open a terminal
  - Run the workshop code under `ghcid`
    ```
    cd reflex-workshop/code
    ./dev.sh
    ```

- Open Chromium 
  - Visit http://localhost:9090 for the workshop
  - Visit http://localhost:8080 for a local Hoogle instance

