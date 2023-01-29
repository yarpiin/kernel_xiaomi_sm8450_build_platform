# kernel_xiaomi_sm8450_build_platform

## Device specifications

| Device                  | Xiaomi 12                                              |
| ----------------------- | :---------------------------------------------------------- |
| SoC     		  | Qualcomm SM8450 Snapdragon 8 Gen 1 (4 nm)                            |
| CPU     		  | Octa-core (1x3.00 GHz Cortex-X2 & 3x2.50 GHz Cortex-A710 & 4x1.80 GHz Cortex-A510)|
| GPU     		  | Adreno 730                                               |
| Memory                  |  128GB 8GB RAM, 256GB 8GB RAM, 256GB 12GB RAM                                   |
| Shipped Android Version | 12 (MIUI 13)                                                |
| Storage                 | 128/256GB                                                   |                                                |
| Battery 		  | Li-Po 4500 mAh non-removable                               |
| Display 		  | AMOLED, 68B colors, 120Hz, Dolby Vision, HDR10+, 1100 nits (peak)|

## Device picture

![Xiaomi 12](https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-12-2.jpg "Xiaomi 12")

## How to build
> * I do assume you know principles of kernel building and have dependencies installed
> * Clone this repo anywhere you want
> * cd cloned directory
> * launch build.sh script
> * follow on screen prompts to clone kernel repo
> * build
> * finished kernel will be created inside of zip folder

## Compatibility
> * Kernels compiled with this platform was tested on 
> - Arian's unofficial LineageOS A13 build
> - MIUI 14.0.4.0.TLCCNXM
