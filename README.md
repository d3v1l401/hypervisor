## Description

The Bareflank Hypervisor is an open source hypervisor Software Development Toolkit (SDK), led by Assured Information Security, Inc. (AIS), that provides the tools needed to rapidly prototype and create your own hypervisor.

Most people think that hypervisors are meant to virtualize servers and provide a means to run Windows on a Mac, but there is a whole field of research where hypervisors are used without guest virtual machines. Since a hypervisor is capable of controlling the host OS running underneath it (so-called "ring -1"), host-only hypervisors support introspection, reverse engineering, anti-virus, containerization, diversity, and even architectural research like [MoRE](https://github.com/ainfosec/MoRE). All of these use cases start the same way, by spending months standing up the hypervisor itself before you can start working on your actual project. Existing open source hypervisors are burdened with legacy support, only support a single operating system or contain unnecessary complexity that make them painful to work with when conducting hypervisor research.

Instead, Bareflank uses a layered, modular approach, that lets you pick just how much complexity you need in your project:
- [BSL](https://github.com/Bareflank/bsl): provides a header-only, AUTOSAR compliant implementation of a subset of the C++ Standard Library, used to implement Bareflank's C++ components ensuring Bareflank and projects built using Bareflank can support critical systems applications like Automotive.
- [LLVM](https://github.com/Bareflank/llvm-project): provides our custom implementation of the LLVM Clang compiler and associated tools including additional static analysis checks in Clang Tidy to ensure compliance with AUTOSAR.
- [PAL](https://github.com/Bareflank/pal): provides auto-generated intrinsics APIs for Intel, AMD and ARM on any combination of OS (e.g., Windows and Linux), ABI (e.g., SysV and MS64) and programming language (e.g., C, C++ and Python).
- [hypervisor](https://github.com/Bareflank/hypervisor): provides the base SDK including the loader, the Bareflank microkernel and support applications. If all you need is host-only hypervisor support, this is the project to start with.
- [MicroV](https://github.com/Bareflank/microv): provides support for guest VMs, allowing the user to create an execute additional virtual machines. If you need guest VM support, this is the project to start with.

To support Bareflank's ecosystem, the hypervisor SDK is licensed under MIT, specifically enabling users of the project to both contribute back to the project, but also create proprietary, closed source products that use the Bareflank SDK as their foundation. Feel free to use Bareflank to create your commercial products. All we ask is that if you find a bug or add a feature to the SDK that you consider contributing your changes back to the project.

## **Quick start**

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bareflank/hypervisor?color=brightgreen)

Get the latest version of the Bareflank Hypervisor SDK from GitHub:

``` bash
git clone https://github.com/bareflank/hypervisor
mkdir bsl/build && cd bsl/build
cmake -GNinja -DCMAKE_CXX_COMPILER="clang++" ..
ninja
```

Enjoy:
```
ninja driver_quick
ninja start
ninja dump
```

## Interested In Working For AIS?
Check out our [Can You Hack It?®](https://www.canyouhackit.com) challenge and test your skills! Submit your score to show us what you’ve got. We have offices across the country and offer  competitive pay and outstanding benefits. Join a team that is not only committed to the future of cyberspace, but to our employee’s success as well.

<p align="center">
  <a href="https://www.ainfosec.com/">
    <img src="https://github.com/Bareflank/MicroV/raw/master/docs/ais.png" alt="cross-platform" height="100" />
  </a>
</p>

## Demo

Check out the latest demo for how to compile and use the Bareflank Hypervisor on Ubuntu 20.04:

## Additional Videos

Check out our [YouTube Channel](https://www.youtube.com/channel/UCH-7Pw96K5V1RHAPn5-cmYA) for more great content as well as
the following videos at [CppCon](https://www.youtube.com/user/CppCon) below:

[![CppCon 2019](https://i.imgur.com/hjZg0pf.png)](https://www.youtube.com/watch?v=bKPN-CGhEC0)
[![CppCon 2017](https://i.imgur.com/nBFD6uA.png)](https://www.youtube.com/watch?v=KdJhQuycD78)
[![CppCon 2016](https://i.imgur.com/fwmlOiJ.png)](https://www.youtube.com/watch?v=uQSQy-7lveQ)

## **Build Requirements**
Currently, the Bareflank hypervisor only supports the Clang/LLVM 11+ compiler. This, however, ensures the hypervisor can be natively compiled on Windows including support for cross-compiling. Support for other C++20 compilers can be added if needed, just let us know if that is something you need.

### **Windows**
To compile the BSL on Windows, you must first install the following:
- [Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16) (Enable "Desktop development with C++")
- [LLVM 11+](https://github.com/llvm/llvm-project/releases)
- [CMake 3.16+](https://cmake.org/download/)
- [Ninja](https://github.com/ninja-build/ninja/releases)

Visual Studio is needed as it contains Windows specific libraries that are needed during compilation. Instead of using the Clang/LLVM project that natively ships with Visual Studio, we use the standard Clang/LLVM binaries provided by the LLVM project which ensures we get all of the tools including LLD, Clang Tidy and Clang Format. Also note that you must put Ninja somewhere
in your path (we usually drop into CMake's bin folder).

To compile the BSL, use the following:
``` bash
git clone https://github.com/bareflank/hypervisor
mkdir hypervisor/build && cd hypervisor/build
cmake -GNinja -DCMAKE_CXX_COMPILER="clang++" -DBUILD_EXAMPLES=ON -DBUILD_TESTS=ON ..
ninja info
ninja
```

### **Ubuntu Linux**
To compile the BSL on Ubuntu, you must install the following:
- [LLVM 11+](https://apt.llvm.org/)
- [CMake 3.16+](https://cmake.org/download/)

Once you have the above setup, you can install all dependencies using the following command
```bash
sudo apt-get install -y clang-11 build-essential git ninja-build
```

You might also have to update your build environment to point to the new version of LLVM as follows:
```
sudo update-alternatives --remove-all clang++
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100
```

To compile the BSL, use the following:
``` bash
git clone https://github.com/bareflank/hypervisor
mkdir hypervisor/build && cd hypervisor/build
cmake -DCMAKE_CXX_COMPILER="clang++" -DBUILD_EXAMPLES=ON -DBUILD_TESTS=ON ..
ninja info
ninja
```

## Usage Instructions

To use the hypervisor, run the following commands:

```
ninja driver_quick
ninja start
```

to get debug information, use the following:

```
ninja dump
```

to reverse this:

```
ninja stop
ninja driver_unload
```

## **Resources**

[![Join the chat](https://img.shields.io/badge/chat-on%20Slack-brightgreen.svg)](https://bareflank.herokuapp.com/)

The Bareflank Support Library provides a ton of useful resources to learn how to use the library including:

-   **Documentation**: <https://bareflank.github.io/hypervisor/>
-   **Examples**: <https://github.com/Bareflank/hypervisor/tree/master/examples>
-   **Unit Tests**: <https://github.com/Bareflank/hypervisor/tree/master/tests>

If you have any questions, bugs, or feature requests, please feel free to ask on any of the following:

-   **Slack**: <https://bareflank.herokuapp.com/>
-   **Issue Tracker**: <https://github.com/Bareflank/hypervisor/issues>

And as always, we are always looking for more help:

-   **Pull Requests**: <https://github.com/Bareflank/hypervisor/pulls>
-   **Contributing Guidelines**: <https://github.com/Bareflank/hypervisor/blob/master/contributing.md>

## **Testing**
The Bareflank hypervisor leverages the following tools to ensure the highest possible code quality. Each pull request undergoes the following rigorous testing and review:

-   **Static Analysis:** [Clang Tidy](https://github.com/Bareflank/llvm-project)
-   **Dynamic Analysis:** Google's ASAN and UBSAN
-   **Code Coverage:** Code Coverage with CodeCov
-   **Coding Standards**: [AUTOSAR C++14](https://www.autosar.org/fileadmin/user_upload/standards/adaptive/17-03/AUTOSAR_RS_CPP14Guidelines.pdf) and [C++ Core Guidelines](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md)
-   **Style**: Clang Format
-   **Documentation**: Doxygen

## Serial Instructions

On Windows, serial output might not work, and on some systems (e.g. Intel NUC),
the default Windows serial device may prevent Bareflank from starting at all.
If this is the case, disable the default serial device using the following:
```
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Serial" /f /v "start" /t REG_DWORD /d "4"
```

## Cygwin SSH Instructions

You might find it useful to setup SSH if you are using Cygwin. The instructions
for setting up SSH on Cygwin are as follows:

```
setup-x86_64.exe -q -P getent,cygrunsrv,openssl,openssh

ssh-host-config -y
<password>
<password>

net start sshd
netsh advfirewall firewall add rule name='SSH Port' dir=in action=allow protocol=TCP localport=22
```

## License

The Bareflank Hypervisor is licensed under the MIT License.

## Related

If you’re interested in Bareflank, you might also be interested in the
following hypervisor projects:

**MoRE:** <br>
https://github.com/ainfosec/MoRE

**SimpleVisor:**  <br>
https://github.com/ionescu007/SimpleVisor

**HyperPlatform:**  <br>
https://github.com/tandasat/HyperPlatform
