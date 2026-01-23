
# Reverse Engineering Tools & Resources
## Comprehensive Guide to RE Tools and Learning Materials

---

## 📚 Table of Contents

1. [Static Analysis Tools](#static-analysis-tools)
2. [Dynamic Analysis Tools](#dynamic-analysis-tools)
3. [Disassemblers & Decompilers](#disassemblers--decompilers)
4. [Debuggers](#debuggers)
5. [Binary Analysis Frameworks](#binary-analysis-frameworks)
6. [Memory & Forensic Analysis](#memory--forensic-analysis)
7. [Network Analysis](#network-analysis)
8. [Mobile RE Tools](#mobile-re-tools)
9. [Firmware & Hardware RE](#firmware--hardware-re)
10. [Automation & Scripting](#automation--scripting)
11. [Online Resources](#online-resources)
12. [Learning Platforms](#learning-platforms)
13. [Books & Publications](#books--publications)
14. [Communities & Forums](#communities--forums)
15. [Practice Platforms](#practice-platforms)

---

## 🔍 Static Analysis Tools

### File Identification & Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **file** | Linux/macOS | Determine file type | Built-in |
| **binwalk** | Cross-platform | Firmware analysis & extraction | [GitHub](https://github.com/ReFirmLabs/binwalk) |
| **TrID** | Windows | File identifier | [GitHub](https://github.com/TrIDSoft/TrID) |
| **ExifTool** | Cross-platform | Metadata analysis | [Website](https://exiftool.org/) |
| **PEiD** | Windows | PE file detector | [GitHub](https://github.com/wolfram77web/PEiD) |
| **Detect It Easy** | Cross-platform | File type detector | [GitHub](https://github.com/horsicq/Detect-It-Easy) |
| **peframe** | Linux | PE analysis tool | [GitHub](https://github.com/guelfoweb/peframe) |

### String Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **strings** | Cross-platform | Extract strings | Built-in |
| **rabin2** | Cross-platform | Radare2 string extractor | Part of radare2 |
| **FLOSS** | Cross-platform | Advanced string extraction | [GitHub](https://github.com/mandiant/flare-floss) |
| **BinText** | Windows | GUI string extractor | [Website](http://www.mcafee.com/us/downloads/free-tools/bintext.aspx) |

### Binary Examination
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **objdump** | Linux/macOS | Object file disassembly | Built-in |
| **readelf** | Linux | ELF file analysis | Built-in |
| **otool** | macOS | Mach-O file analysis | Built-in |
| **PEview** | Windows | PE file viewer | [Website](http://wjradburn.com/software/) |
| **CFF Explorer** | Windows | PE editor | [Website](https://ntcore.com/?page_id=388) |
| **PE-bear** | Cross-platform | PE analysis | [GitHub](https://github.com/hasherezade/pe-bear) |

---

## 🐛 Dynamic Analysis Tools

### System Call Tracing
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **strace** | Linux | System call tracer | Built-in |
| **ltrace** | Linux | Library call tracer | Built-in |
| **dtrace** | Solaris/macOS | Dynamic tracing | Built-in |
| **Process Monitor** | Windows | Real-time monitoring | [Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon) |
| **API Monitor** | Windows | API call monitoring | [Website](http://www.rohitab.com/apimonitor) |

### Sandboxes & VM Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Cuckoo Sandbox** | Linux | Automated malware analysis | [GitHub](https://github.com/cuckoosandbox/cuckoo) |
| **Joe Sandbox** | Cloud/Windows | Commercial sandbox | [Website](https://www.joesandbox.com/) |
| **Any.Run** | Cloud | Interactive malware analysis | [Website](https://any.run/) |
| **Hybrid Analysis** | Cloud | Free sandbox | [Website](https://www.hybrid-analysis.com/) |
| **VirusTotal** | Cloud | Multi-engine scanner | [Website](https://www.virustotal.com/) |

### Behavior Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Process Hacker** | Windows | Process viewer/manager | [GitHub](https://github.com/processhacker/processhacker) |
| **Process Explorer** | Windows | Advanced task manager | [Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) |
| **Regshot** | Windows | Registry comparison | [GitHub](https://github.com/Regshot/Regshot) |
| **Capture BAT** | Windows | Behavior analysis tool | [GitHub](https://github.com/CERT-Polska/CaptureBAT) |

---

## 🏗️ Disassemblers & Decompilers

### Commercial Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **IDA Pro** | Windows/Linux/macOS | Industry standard disassembler | [Hex-Rays](https://hex-rays.com/ida-pro/) |
| **Binary Ninja** | Cross-platform | Modern disassembler | [Vector35](https://binary.ninja/) |
| **Hopper** | macOS/Linux | Reverse engineering tool | [Website](https://www.hopperapp.com/) |
| **JEB** | Cross-platform | Decompiler | [PNF Software](https://www.pnfsoftware.com/) |

### Free/Open Source Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Ghidra** | Cross-platform | NSA's RE framework | [GitHub](https://github.com/NationalSecurityAgency/ghidra) |
| **radare2** | Cross-platform | Unix-like RE framework | [GitHub](https://github.com/radareorg/radare2) |
| **Cutter** | Cross-platform | GUI for radare2 | [GitHub](https://github.com/rizinorg/cutter) |
| **Medusa** | Cross-platform | Collaborative disassembler | [GitHub](https://github.com/wisk/medusa) |
| **RetDec** | Cross-platform | Retargetable decompiler | [GitHub](https://github.com/avast/retdec) |
| **Snowman** | Windows/Linux | Native code to C/C++ decompiler | [GitHub](https://github.com/yegord/snowman) |

### Online Decompilers
| Tool | Description | Link |
|------|-------------|------|
| **Decompiler Explorer** | Compare decompilers online | [Website](https://dogbolt.org/) |
| **RetDec Online** | Web interface for RetDec | [Website](https://retdec.com/) |

---

## 🔧 Debuggers

### System Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **GDB** | Linux/macOS | GNU Debugger | [Website](https://www.gnu.org/software/gdb/) |
| **x64dbg** | Windows | Open-source x64/x32 debugger | [GitHub](https://github.com/x64dbg/x64dbg) |
| **WinDbg** | Windows | Microsoft debugger | [Microsoft](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/) |
| **LLDB** | Cross-platform | LLVM debugger | [Website](https://lldb.llvm.org/) |
| **OllyDbg** | Windows | 32-bit debugger | [Website](http://www.ollydbg.de/) |
| **Immunity Debugger** | Windows | Python-scriptable debugger | [Website](https://www.immunityinc.com/products/debugger/) |

### Enhanced Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **PEDA** | Linux | Python Exploit Development Assistance for GDB | [GitHub](https://github.com/longld/peda) |
| **GEF** | Linux | GDB Enhanced Features | [GitHub](https://github.com/hugsy/gef) |
| **pwndbg** | Linux | GDB plug-in for exploit dev | [GitHub](https://github.com/pwndbg/pwndbg) |
| **Vegile** | Linux | Anti-debugging detection | [GitHub](https://github.com/Screetsec/Vegile) |

### Kernel Debuggers
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **WinDbg Preview** | Windows | Modern kernel/user debugger | [Microsoft Store](https://www.microsoft.com/en-us/p/windbg/9pgjgd53tn86) |
| **Volatility** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/volatilityfoundation/volatility) |
| **rekall** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/google/rekall) |

---

## 🏗️ Binary Analysis Frameworks

### Analysis Frameworks
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **angr** | Python | Binary analysis platform | [GitHub](https://github.com/angr/angr) |
| **BAP** | OCaml | Binary Analysis Platform | [GitHub](https://github.com/BinaryAnalysisPlatform/bap) |
| **Manticore** | Python | Symbolic execution tool | [GitHub](https://github.com/trailofbits/manticore) |
| **PANDA** | C++ | Platform for dynamic analysis | [GitHub](https://github.com/panda-re/panda) |
| **S2E** | C++ | Selective symbolic execution | [GitHub](https://github.com/S2E/s2e) |
| **Triton** | C++/Python | Dynamic binary analysis | [GitHub](https://github.com/JonathanSalwan/Triton) |

### Library-Based Tools
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **Capstone** | C/Python | Disassembly framework | [GitHub](https://github.com/capstone-engine/capstone) |
| **Keystone** | C/Python | Assembler framework | [GitHub](https://github.com/keystone-engine/keystone) |
| **Unicorn** | C/Python | CPU emulator framework | [GitHub](https://github.com/unicorn-engine/unicorn) |
| **pefile** | Python | PE file parser | [GitHub](https://github.com/erocarrera/pefile) |
| **LIEF** | C++/Python | Library to instrument executable formats | [GitHub](https://github.com/lief-project/LIEF) |
| **pyelftools** | Python | ELF file parser | [GitHub](https://github.com/eliben/pyelftools) |

---

## 🧠 Memory & Forensic Analysis

### Memory Acquisition
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **FTK Imager** | Windows | Memory acquisition | [AccessData](https://accessdata.com/product-download/ftk-imager-version-4-5) |
| **WinPmem** | Windows | Memory acquisition | [GitHub](https://github.com/Velocidex/WinPmem) |
| **LiME** | Linux | Linux Memory Extractor | [GitHub](https://github.com/504ensicsLabs/LiME) |
| **OSXPMem** | macOS | Memory acquisition | [GitHub](https://github.com/google/rekall/tree/master/tools/osx) |

### Memory Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Volatility** | Cross-platform | Memory forensics framework | [GitHub](https://github.com/volatilityfoundation/volatility) |
| **Rekall** | Cross-platform | Memory analysis framework | [GitHub](https://github.com/google/rekall) |
| **Redline** | Windows | Memory analysis | [FireEye](https://www.fireeye.com/services/freeware/redline.html) |
| **Memoryze** | Windows | Memory analysis | [FireEye](https://www.fireeye.com/services/freeware/memoryze.html) |

### Disk Forensics
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Autopsy** | Cross-platform | Digital forensics platform | [GitHub](https://github.com/sleuthkit/autopsy) |
| **Sleuth Kit** | Cross-platform | Forensic toolkit | [GitHub](https://github.com/sleuthkit/sleuthkit) |
| **FTK** | Windows | Commercial forensics suite | [AccessData](https://accessdata.com/products-services/forensic-toolkit-ftk) |
| **EnCase** | Windows | Commercial forensics | [Opentext](https://www.opentext.com/products/encase-forensic) |

---

## 🌐 Network Analysis

### Packet Capture
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Wireshark** | Cross-platform | Network protocol analyzer | [Website](https://www.wireshark.org/) |
| **tcpdump** | Linux/macOS | Command-line packet analyzer | Built-in |
| **Microsoft Message Analyzer** | Windows | Network analyzer | [Microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=44226) |
| **Zeek** | Linux | Network analysis framework | [GitHub](https://github.com/zeek/zeek) |

### Traffic Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **NetworkMiner** | Windows | Network forensic analysis | [Website](https://www.netresec.com/?page=NetworkMiner) |
| **CapLoader** | Windows | Advanced PCAP analysis | [Website](https://www.cap-loader.com/) |
| **Moloch** | Linux | Large scale PCAP indexing | [GitHub](https://github.com/aol/moloch) |
| **Suricata** | Cross-platform | Network IDS/IPS | [GitHub](https://github.com/OISF/suricata) |

### Protocol Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Scapy** | Python | Packet manipulation | [GitHub](https://github.com/secdev/scapy) |
| **Netzob** | Python | Protocol reverse engineering | [GitHub](https://github.com/netzob/netzob) |
| **CANalyzat0r** | Linux | CAN bus analysis | [GitHub](https://github.com/schutzwerk/CANalyzat0r) |

---

## 📱 Mobile RE Tools

### Android Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **JADX** | Cross-platform | Dex to Java decompiler | [GitHub](https://github.com/skylot/jadx) |
| **APKTool** | Cross-platform | Reverse engineering APK files | [GitHub](https://github.com/iBotPeaches/Apktool) |
| **Frida** | Cross-platform | Dynamic instrumentation toolkit | [GitHub](https://github.com/frida/frida) |
| **Objection** | Python | Runtime mobile exploration | [GitHub](https://github.com/sensepost/objection) |
| **MobSF** | Cross-platform | Mobile security framework | [GitHub](https://github.com/MobSF/Mobile-Security-Framework-MobSF) |
| **Androguard** | Python | Android reverse engineering | [GitHub](https://github.com/androguard/androguard) |

### iOS Tools
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **class-dump** | macOS | Objective-C class info dumper | [GitHub](https://github.com/nygard/class-dump) |
| **Hopper** | macOS/Linux | Disassembler for macOS/iOS | [Website](https://www.hopperapp.com/) |
| **Cycript** | iOS/macOS | Injected JavaScript interpreter | [GitHub](https://github.com/cycript/cycript) |
| **iOS App Signer** | macOS | iOS app resigning | [GitHub](https://github.com/DanTheMan827/ios-app-signer) |
| **MachOView** | macOS | Mach-O file viewer | [GitHub](https://github.com/gdbinit/MachOView) |

### Mobile Emulators
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Android Studio** | Cross-platform | Official Android emulator | [Website](https://developer.android.com/studio) |
| **Genymotion** | Cross-platform | Android emulator | [Website](https://www.genymotion.com/) |
| **Corellium** | Web | Virtual iOS devices | [Website](https://www.corellium.com/) |

---

## 💾 Firmware & Hardware RE

### Firmware Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Binwalk** | Cross-platform | Firmware analysis tool | [GitHub](https://github.com/ReFirmLabs/binwalk) |
| **FACT** | Linux | Firmware analysis and comparison | [GitHub](https://github.com/fkie-cad/FACT_core) |
| **Firmadyne** | Linux | Firmware emulation | [GitHub](https://github.com/firmadyne/firmadyne) |
| **Firmware Analysis Toolkit** | Linux | Automated firmware analysis | [GitHub](https://github.com/attify/firmware-analysis-toolkit) |
| **AMD Flasher** | Linux | AMD BIOS flasher | [GitHub](https://github.com/skylarstein/amdflasher) |

### Hardware Tools
| Tool | Type | Description |
|------|------|-------------|
| **JTAGulator** | Hardware | JTAG discovery tool |
| **Bus Pirate** | Hardware | Multi-protocol tool |
| **Saleae Logic** | Hardware | Logic analyzer |
| **ChipWhisperer** | Hardware | Side-channel analysis |
| **Shikra** | Hardware | JTAG/SWD debugger |

### Chip Analysis
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **Ghidra** | Cross-platform | Supports many architectures | [GitHub](https://github.com/NationalSecurityAgency/ghidra) |
| **Binary Ninja** | Cross-platform | Multiple architecture support | [Website](https://binary.ninja/) |
| **radare2** | Cross-platform | Wide architecture support | [GitHub](https://github.com/radareorg/radare2) |

---

## 🤖 Automation & Scripting

### Python Libraries
| Library | Description | Link |
|---------|-------------|------|
| **pwntools** | CTF framework and exploit dev | [GitHub](https://github.com/Gallopsled/pwntools) |
| **ropper** | ROP gadget finder | [GitHub](https://github.com/sashs/Ropper) |
| **z3** | Theorem prover | [GitHub](https://github.com/Z3Prover/z3) |
| **angr** | Binary analysis | [GitHub](https://github.com/angr/angr) |
| **frida** | Dynamic instrumentation | [GitHub](https://github.com/frida/frida) |
| **unicorn** | CPU emulator | [GitHub](https://github.com/unicorn-engine/unicorn) |
| **keystone** | Assembler framework | [GitHub](https://github.com/keystone-engine/keystone) |
| **capstone** | Disassembler framework | [GitHub](https://github.com/capstone-engine/capstone) |

### Scripting Environments
| Tool | Platform | Description | Link |
|------|----------|-------------|------|
| **IDA Python** | IDA Pro | Python scripting in IDA | Built-in |
| **Binary Ninja API** | Binary Ninja | Python API | Built-in |
| **Ghidra Scripting** | Ghidra | Java/Python scripting | Built-in |
| **radare2 r2pipe** | radare2 | Pipe interface for scripting | [GitHub](https://github.com/radareorg/radare2-r2pipe) |

### Automation Frameworks
| Tool | Language | Description | Link |
|------|----------|-------------|------|
| **BARF** | Python | Binary Analysis and Reverse engineering Framework | [GitHub](https://github.com/programa-stic/barf-project) |
| **Binnavi** | Java | Binary analysis IDE | [GitHub](https://github.com/google/binnavi) |
| **Vivisect** | Python | Pure Python analysis/emulation | [GitHub](https://github.com/vivisect/vivisect) |

---

## 🌐 Online Resources

### Analysis Services
| Service | Description | Link |
|---------|-------------|------|
| **VirusTotal** | File scanning service | [Website](https://www.virustotal.com/) |
| **Hybrid Analysis** | Free malware analysis | [Website](https://www.hybrid-analysis.com/) |
| **Any.Run** | Interactive malware analysis | [Website](https://any.run/) |
| **Joe Sandbox** | Malware analysis | [Website](https://www.joesandbox.com/) |
| **Intezer Analyze** | Genetic malware analysis | [Website](https://analyze.intezer.com/) |

### Knowledge Bases
| Resource | Description | Link |
|----------|-------------|------|
| **MITRE ATT&CK** | Adversary tactics and techniques | [Website](https://attack.mitre.org/) |
| **Malpedia** | Malware encyclopedia | [Website](https://malpedia.caad.fkie.fraunhofer.de/) |
| **MalwareBazaar** | Malware sample exchange | [Website](https://bazaar.abuse.ch/) |
| **VirusShare** | Malware sample repository | [Website](https://virusshare.com/) |
| **TheZoo** | Live malware repository | [GitHub](https://github.com/ytisf/theZoo) |

### Documentation & References
| Resource | Description | Link |
|----------|-------------|------|
| **Intel Manuals** | x86/x64 architecture | [Intel](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html) |
| **AMD Manuals** | AMD64 architecture | [AMD](https://www.amd.com/en/support/tech-docs) |
| **ARM Documentation** | ARM architecture | [ARM](https://developer.arm.com/documentation) |
| **PE Format** | Microsoft PE specification | [Microsoft](https://docs.microsoft.com/en-us/windows/win32/debug/pe-format) |
| **ELF Format** | ELF specification | [Tool Interface Standard](http://www.sco.com/developers/gabi/latest/contents.html) |

---

## 🎓 Learning Platforms

### Online Courses
| Platform | Course | Description |
|----------|--------|-------------|
| **OpenSecurityTraining** | Introductory x86 | Free x86 RE course |
| **SANS Institute** | FOR610 | Reverse Engineering Malware |
| **Pentester Academy** | x86_64 Assembly | Assembly language for hackers |
| **Udemy** | Various | Multiple RE courses |
| **Coursera** | Binary Exploitation | University courses |

### Video Tutorials
| Channel | Platform | Focus |
|---------|----------|-------|
| **LiveOverflow** | YouTube | Binary exploitation, RE |
| **GynvaelEN** | YouTube | Security, RE, CTF |
| **IppSec** | YouTube | HackTheBox walkthroughs |
| **John Hammond** | YouTube | CTF, malware analysis |
| **OALabs** | YouTube | Open Analysis Labs tutorials |

### Interactive Learning
| Platform | Description | Link |
|----------|-------------|------|
| **CTFtime** | CTF calendar | [Website](https://ctftime.org/) |
| **picoCTF** | Beginner-friendly CTF | [Website](https://picoctf.org/) |
| **OverTheWire** | War games | [Website](https://overthewire.org/wargames/) |
| **HackTheBox** | Penetration testing labs | [Website](https://www.hackthebox.com/) |
| **TryHackMe** | Learning paths | [Website](https://tryhackme.com/) |

---

## 📚 Books & Publications

### Foundational Books
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **Practical Malware Analysis** | Michael Sikorski, Andrew Honig | 2012 | Malware analysis |
| **The IDA Pro Book** | Chris Eagle | 2011 | IDA Pro usage |
| **Reversing: Secrets of Reverse Engineering** | Eldad Eilam | 2005 | General RE |
| **The Ghidra Book** | Chris Eagle, Kara Nance | 2020 | Ghidra usage |
| **The Art of Memory Forensics** | Michael Hale Ligh, et al. | 2014 | Memory analysis |

### Technical References
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **Intel 64 and IA-32 Architectures Software Developer Manuals** | Intel | Ongoing | x86/x64 |
| **System V Application Binary Interface** | Various | Ongoing | ABI specifications |
| **PE Format Specification** | Microsoft | Ongoing | Windows PE format |
| **ARM Architecture Reference Manual** | ARM Ltd. | Ongoing | ARM architecture |

### Advanced Topics
| Book | Author | Year | Focus |
|------|--------|------|-------|
| **The Shellcoder's Handbook** | Chris Anley, et al. | 2007 | Exploit development |
| **Rootkits: Subverting the Windows Kernel** | Greg Hoglund, James Butler | 2005 | Rootkit development |
| **Android Hacker's Handbook** | Joshua Drake, et al. | 2014 | Android security |
| **iOS Hacker's Handbook** | Charlie Miller, et al. | 2012 | iOS security |
| **The Practice of Network Security Monitoring** | Richard Bejtlich | 2013 | Network monitoring |

---

## 👥 Communities & Forums

### Online Communities
| Community | Platform | Focus |
|-----------|----------|-------|
| **Reverse Engineering Subreddit** | Reddit | General RE |
| **Malware Analysis Subreddit** | Reddit | Malware focus |
| **Ghidra Discord** | Discord | Ghidra users |
| **Radare2 Discord** | Discord | Radare2 users |
| **Binary Ninja Slack** | Slack | Binary Ninja users |

### Forums & Discussion Boards
| Forum | Description | Link |
|-------|-------------|------|
| **Reverse Engineering Stack Exchange** | Q&A site | [Website](https://reverseengineering.stackexchange.com/) |
| **OpenRCE Forums** | RE discussion | [Website](http://www.openrce.org/forums/) |
| **Woodmann's RE Forum** | Long-standing RE forum | [Website](https://forum.woodmann.com/) |
| **Tuts4You** | RE tutorials and forums | [Website](https://tuts4you.com/) |
| **Crackmes.one Forum** | Crackme discussions | [Website](https://crackmes.one/forum/) |

### Conference Materials
| Conference | Materials | Link |
|------------|-----------|------|
| **REcon** | Presentations | [Website](https://recon.cx/) |
| **Black Hat** | Presentations | [Website](https://www.blackhat.com/) |
| **DEF CON** | Presentations | [Website](https://defcon.org/) |
| **Chaos Communication Congress** | Recordings | [Website](https://media.ccc.de/) |

---

## 🎯 Practice Platforms

### Crackme Collections
| Platform | Description | Link |
|----------|-------------|------|
| **Crackmes.one** | Largest crackme collection | [Website](https://crackmes.one/) |
| **Reversing.kr** | Korean crackme site | [Website](http://reversing.kr/) |
| **PELock CrackMe** | Windows crackmes | [Website](https://www.pelock.com/products/crackme) |
| **Crackmes.de Archive** | Archived crackmes | [Website](https://crackmes.de/) |

### Malware Analysis Practice
| Resource | Description | Link |
|----------|-------------|------|
| **Malware Traffic Analysis** | Network traffic exercises | [Website](https://www.malware-traffic-analysis.net/) |
| **Malware Analysis Exercises** | Practical exercises | [GitHub](https://github.com/rshipp/awesome-malware-analysis#exercises) |
| **FlareVM** | Windows RE VM | [GitHub](https://github.com/fireeye/flare-vm) |
| **REMnux** | Linux RE distro | [Website](https://remnux.org/) |

### CTF Platforms
| Platform | Description | Link |
|----------|-------------|------|
| **picoCTF** | Beginner CTF | [Website](https://picoctf.org/) |
| **HackTheBox** | Challenge-based | [Website](https://www.hackthebox.com/) |
| **TryHackMe** | Learning-focused | [Website](https://tryhackme.com/) |
| **CTFlearn** | Community CTF | [Website](https://ctflearn.com/) |
| **WeChall** | Challenge aggregator | [Website](https://www.wechall.net/) |

---

## 🚀 Getting Started Guide

### Step 1: Setup Your Environment
1. **Install a Linux VM** (Ubuntu/Debian recommended)
2. **Setup basic tools**: 
   ```bash
   sudo apt install gdb radare2 binwalk strace ltrace
   ```
3. **Install Python libraries**:
   ```bash
   pip install pwntools capstone keystone unicorn
   ```

### Step 2: Learn the Basics
1. **Start with simple crackmes** from crackmes.one
2. **Follow tutorials** from LiveOverflow YouTube
3. **Practice assembly** with microcorruption.com

### Step 3: Choose Your Tools
- **Beginner**: Ghidra + GDB
- **Intermediate**: radare2 + Binary Ninja
- **Advanced**: IDA Pro + custom scripts

### Step 4: Specialize
1. **Malware Analysis**: REMnux + FlareVM
2. **Mobile RE**: Android Studio + JADX
3. **Firmware RE**: Binwalk + QEMU
4. **Game RE**: Cheat Engine + x64dbg

---

## 📈 Skill Development Path

### Month 1-3: Foundation
- Learn x86/x64 assembly
- Master GDB basics
- Solve easy crackmes
- Understand PE/ELF formats

### Month 4-6: Intermediate
- Learn Python for RE
- Master radare2/Ghidra
- Solve medium crackmes
- Study common algorithms

### Month 7-12: Advanced
- Learn anti-debug techniques
- Study malware analysis
- Participate in CTFs
- Contribute to open-source tools

### Year 2+: Specialization
- Choose a focus area
- Develop expertise
- Contribute research
- Mentor others

---

## ⚠️ Legal & Ethical Considerations

### Always:
- Only analyze software you own or have permission to analyze
- Respect licenses and copyrights
- Use isolated environments (VMs)
- Follow responsible disclosure

### Never:
- Reverse engineer for piracy
- Analyze systems without authorization
- Use skills for illegal activities
- Share sensitive information

### Resources for Ethics:
- **IEEE Code of Ethics**
- **ACM Code of Ethics**
- **EC-Council Code of Ethics**
- **Local laws and regulations**

---

## 🎉 Final Thoughts

Reverse engineering is a journey, not a destination. The field is constantly evolving, and there's always more to learn. 

### Key Principles:
1. **Be curious** - The best reversers are naturally curious
2. **Be persistent** - Complex problems take time
3. **Be ethical** - Use your skills responsibly
4. **Be collaborative** - Share knowledge with the community
5. **Be adaptable** - Tools and techniques change

### Remember:
- Start simple and build up
- Document everything
- Practice regularly
- Join communities
- Have fun!

Happy reversing! 🚀🔍

*Last Updated: 2024*
```

### **docs/references/assembly_opcodes.md**
```markdown
# Assembly Opcodes Reference
## Complete x86/x64, ARM, ARM64, MIPS Opcode Tables

---

## 📚 Table of Contents

1. [x86/x64 Opcodes](#x86x64-opcodes)
2. [ARM/ARM64 Opcodes](#armarm64-opcodes)
3. [MIPS Opcodes](#mips-opcodes)
4. [Common Instruction Patterns](#common-instruction-patterns)
5. [Opcode Mnemonics](#opcode-mnemonics)
6. [Encoding Reference](#encoding-reference)
7. [Quick Reference Tables](#quick-reference-tables)

---

## 🏗️ x86/x64 Opcodes

### Data Transfer Instructions

| Instruction | Opcode | Description | Flags Affected |
|-------------|--------|-------------|----------------|
| **MOV r/m, r** | 88-8B | Move register to r/m | None |
| **MOV r, r/m** | 8A-8B | Move r/m to register | None |
| **MOV r/m, imm** | C6/C7 | Move immediate to r/m | None |
| **MOV r, imm** | B0-B7 | Move immediate to register | None |
| **MOVZX r, r/m** | 0F B6/B7 | Move with zero extend | None |
| **MOVSX r, r/m** | 0F BE/BF | Move with sign extend | None |
| **LEA r, m** | 8D | Load effective address | None |
| **XCHG r/m, r** | 86-87 | Exchange register with r/m | None |
| **PUSH r/m** | 50-57/FF | Push onto stack | None |
| **POP r/m** | 58-5F/8F | Pop from stack | None |
| **PUSHF/PUSHFD/PUSHFQ** | 9C | Push flags onto stack | None |
| **POPF/POPFD/POPFQ** | 9D | Pop flags from stack | All |

### Arithmetic Instructions

| Instruction | Opcode | Description | Flags Affected |
|-------------|--------|-------------|----------------|
| **ADD r/m, r** | 00-03 | Add register to r/m | OF, SF, ZF, AF, CF, PF |
| **ADD r, r/m** | 02-03 | Add r/m to register | OF, SF, ZF, AF, CF, PF |
| **ADD r/m, imm** | 80/81 | Add immediate to r/m | OF, SF, ZF, AF, CF, PF |
| **ADC r/m, r** | 10-13 | Add with carry | OF, SF, ZF, AF, CF, PF |
| **SUB r/m, r** | 28-2B | Subtract register from r/m | OF, SF, ZF, AF, CF, PF |
| **SUB r, r/m** | 2A-2B | Subtract r/m from register | OF, SF, ZF, AF, CF, PF |
| **SBB r/m, r** | 18-1B | Subtract with borrow | OF, SF, ZF, AF, CF, PF |
| **INC r/m** | FE/FF | Increment by 1 | OF, SF, ZF, AF, PF |
| **DEC r/m** | FE/FF | Decrement by 1 | OF, SF, ZF, AF, PF |
| **NEG r/m** | F6/F7 | Two's complement negation | CF, OF, SF, ZF, AF, PF |
| **CMP r/m, r** | 38-3B | Compare register with r/m | OF, SF, ZF, AF, CF, PF |
| **CMP r, r/m** | 3A-3B | Compare r/m with register | OF, SF, ZF, AF, CF, PF |

### Multiplication & Division

| Instruction | Opcode | Description | Flags Affected |
|-------------|--------|-------------|----------------|
| **MUL r/m** | F6/F7 | Unsigned multiply (AL/AX/EAX/RAX) | OF, CF (SF,ZF,AF,PF undefined) |
| **IMUL r/m** | F6/F7 | Signed multiply | OF, CF (SF,ZF,AF,PF undefined) |
| **IMUL r, r/m** | 0F AF | Signed multiply | OF, CF (SF,ZF,AF,PF undefined) |
| **IMUL r, r/m, imm** | 69/6B | Signed multiply with immediate | OF, CF (SF,ZF,AF,PF undefined) |
| **DIV r/m** | F6/F7 | Unsigned divide | All undefined |
| **IDIV r/m** | F6/F7 | Signed divide | All undefined |

### Logical & Bit Instructions

| Instruction | Opcode | Description | Flags Affected |
|-------------|--------|-------------|----------------|
| **AND r/m, r** | 20-23 | Logical AND | OF=0, SF, ZF, PF, CF=0 |
| **AND r, r/m** | 22-23 | Logical AND | OF=0, SF, ZF, PF, CF=0 |
| **OR r/m, r** | 08-0B | Logical OR | OF=0, SF, ZF, PF, CF=0 |
| **OR r, r/m** | 0A-0B | Logical OR | OF=0, SF, ZF, PF, CF=0 |
| **XOR r/m, r** | 30-33 | Logical XOR | OF=0, SF, ZF, PF, CF=0 |
| **XOR r, r/m** | 32-33 | Logical XOR | OF=0, SF, ZF, PF, CF=0 |
| **NOT r/m** | F6/F7 | One's complement negation | None |
| **TEST r/m, r** | 84-85 | Logical compare (AND) | OF=0, SF, ZF, PF, CF=0 |
| **SHL/SAL r/m, 1** | D0/D2 | Shift left / arithmetic left | OF, SF, ZF, PF, CF |
| **SHR r/m, 1** | D0/D2 | Shift right logical | OF, SF, ZF, PF, CF |
| **SAR r/m, 1** | D0/D2 | Shift right arithmetic | OF, SF, ZF, PF, CF |
| **ROL r/m, 1** | D0/D2 | Rotate left | OF, CF |
| **ROR r/m, 1** | D0/D2 | Rotate right | OF, CF |

### Control Transfer

| Instruction | Opcode | Description | Flags Used |
|-------------|--------|-------------|------------|
| **JMP rel8** | EB | Jump short | None |
| **JMP rel32** | E9 | Jump near | None |
| **JMP r/m** | FF | Jump indirect | None |
| **CALL rel32** | E8 | Call near | None |
| **CALL r/m** | FF | Call indirect | None |
| **RET** | C3 | Return near | None |
| **RET imm16** | C2 | Return with stack adjustment | None |
| **JE/JZ rel8** | 74 | Jump if equal/zero | ZF=1 |
| **JNE/JNZ rel8** | 75 | Jump if not equal/not zero | ZF=0 |
| **JL/JNGE rel8** | 7C | Jump if less/not greater or equal | SF≠OF |
| **JGE/JNL rel8** | 7D | Jump if greater or equal/not less | SF=OF |
| **JLE/JNG rel8** | 7E | Jump if less or equal/not greater | ZF=1 or SF≠OF |
| **JG/JNLE rel8** | 7F | Jump if greater/not less or equal | ZF=0 and SF=OF |
| **JC/JB/JNAE rel8** | 72 | Jump if carry/below/not above or equal | CF=1 |
| **JNC/JNB/JAE rel8** | 73 | Jump if not carry/not below/above or equal | CF=0 |
| **JO rel8** | 70 | Jump if overflow | OF=1 |
| **JNO rel8** | 71 | Jump if not overflow | OF=0 |
| **JS rel8** | 78 | Jump if sign | SF=1 |
| **JNS rel8** | 79 | Jump if not sign | SF=0 |
| **LOOP rel8** | E2 | Loop while ECX/RCX ≠ 0 | None |

### String Instructions

| Instruction | Opcode | Description | Direction Flag |
|-------------|--------|-------------|----------------|
| **MOVSB** | A4 | Move byte from string to string | DF |
| **MOVSW** | A5 | Move word from string to string | DF |
| **MOVSD** | A5 | Move dword from string to string | DF |
| **CMPSB** | A6 | Compare byte strings | DF |
| **CMPSW** | A7 | Compare word strings | DF |
| **CMPSD** | A7 | Compare dword strings | DF |
| **SCASB** | AE | Scan byte string | DF |
| **SCASW** | AF | Scan word string | DF |
| **SCASD** | AF | Scan dword string | DF |
| **LODSB** | AC | Load byte from string | DF |
| **LODSW** | AD | Load word from string | DF |
| **LODSD** | AD | Load dword from string | DF |
| **STOSB** | AA | Store byte to string | DF |
| **STOSW** | AB | Store word to string | DF |
| **STOSD** | AB | Store dword to string | DF |

### Flag & System Instructions

| Instruction | Opcode | Description | Privilege Level |
|-------------|--------|-------------|-----------------|
| **STC** | F9 | Set carry flag | All |
| **CLC** | F8 | Clear carry flag | All |
| **CMC** | F5 | Complement carry flag | All |
| **STD** | FD | Set direction flag | All |
| **CLD** | FC | Clear direction flag | All |
| **STI** | FB | Set interrupt flag | All |
| **CLI** | FA | Clear interrupt flag | All |
| **LAHF** | 9F | Load flags into AH | All |
| **SAHF** | 9E | Store AH into flags | All |
| **PUSHF** | 9C | Push flags onto stack | All |
| **POPF** | 9D | Pop flags from stack | All |
| **INT n** | CD | Software interrupt | All |
| **INTO** | CE | Interrupt on overflow | All |
| **IRET** | CF | Interrupt return | All |
| **HLT** | F4 | Halt processor | Ring 0 |
| **IN** | E4-E7 | Input from port | IOPL |
| **OUT** | E6-E7 | Output to port | IOPL |
| **CPUID** | 0F A2 | CPU identification | All |
| **RDTSC** | 0F 31 | Read time-stamp counter | All |
| **RDMSR** | 0F 32 | Read model-specific register | Ring 0 |
| **WRMSR** | 0F 30 | Write model-specific register | Ring 0 |
| **SYSCALL** | 0F 05 | Fast system call | User/Ring 0 |
| **SYSENTER** | 0F 34 | Fast system call entry | User/Ring 0 |
| **SYSRET** | 0F 07 | Return from fast system call | Ring 0 |
| **SYSEXIT** | 0F 35 | Exit from fast system call | Ring 0 |

### x64 Specific Instructions

| Instruction | Opcode | Description | Flags |
|-------------|--------|-------------|-------|
| **MOVSXD r64, r/m32** | 63 | Move with sign extend (32→64) | None |
| **SWAPGS** | 0F 01 F8 | Swap GS base register | None |
| **SYSCALL** | 0F 05 | Fast system call | None |
| **SYSRET** | 0F 07 | Return from fast system call | None |

### SIMD Instructions (Selected)

| Instruction | Opcode Prefix | Description |
|-------------|---------------|-------------|
| **MOVDQA** | 66 0F 6F/7F | Move aligned double quadword |
| **MOVDQU** | F3 0F 6F/7F | Move unaligned double quadword |
| **PADDB/W/D/Q** | 0F FC-FD | Packed add bytes/words/dwords/qwords |
| **PSUBB/W/D/Q** | 0F F8-F9 | Packed subtract bytes/words/dwords/qwords |
| **PAND** | 0F DB | Packed AND |
| **POR** | 0F EB | Packed OR |
| **PXOR** | 0F EF | Packed XOR |
| **PSLLW/D/Q** | 0F F1/F2 | Packed shift left logical |
| **PSRLW/D/Q** | 0F D1/D2 | Packed shift right logical |
| **PSRAW/D** | 0F E1/E2 | Packed shift right arithmetic |

---

## 🏗️ ARM/ARM64 Opcodes

### ARM32 Instruction Encoding

#### Data Processing (ALU)

| Instruction | Cond | Opcode | S | Rn | Rd | Operand2 |
|-------------|------|--------|---|---|---|----------|
| **AND** | cond | 0000 | S | Rn | Rd | shifter_operand |
| **EOR** | cond | 0001 | S | Rn | Rd | shifter_operand |
| **SUB** | cond | 0010 | S | Rn | Rd | shifter_operand |
| **RSB** | cond | 0011 | S | Rn | Rd | shifter_operand |
| **ADD** | cond | 0100 | S | Rn | Rd | shifter_operand |
| **ADC** | cond | 0101 | S | Rn | Rd | shifter_operand |
| **SBC** | cond | 0110 | S | Rn | Rd | shifter_operand |
| **RSC** | cond | 0111 | S | Rn | Rd | shifter_operand |
| **TST** | cond | 1000 | 1 | Rn | 0000 | shifter_operand |
| **TEQ** | cond | 1001 | 1 | Rn | 0000 | shifter_operand |
| **CMP** | cond | 1010 | 1 | Rn | 0000 | shifter_operand |
| **CMN** | cond | 1011 | 1 | Rn | 0000 | shifter_operand |
| **ORR** | cond | 1100 | S | Rn | Rd | shifter_operand |
| **MOV** | cond | 1101 | S | 0000 | Rd | shifter_operand |
| **BIC** | cond | 1110 | S | Rn | Rd | shifter_operand |
| **MVN** | cond | 1111 | S | 0000 | Rd | shifter_operand |

#### Multiply Instructions

| Instruction | Cond | Opcode | S | Rd | Rn | Rs | 1 | Rm |
|-------------|------|--------|---|---|---|---|---|---|---|
| **MUL** | cond | 0000 | S | Rd | Rn | Rs | 0 | Rm |
| **MLA** | cond | 0001 | S | Rd | Rn | Rs | 0 | Rm |
| **UMULL** | cond | 0100 | S | RdLo | RdHi | Rs | 1 | Rm |
| **UMLAL** | cond | 0101 | S | RdLo | RdHi | Rs | 1 | Rm |
| **SMULL** | cond | 0110 | S | RdLo | RdHi | Rs | 1 | Rm |
| **SMLAL** | cond | 0111 | S | RdLo | RdHi | Rs | 1 | Rm |

#### Branch Instructions

| Instruction | Cond | 101 | L | Offset |
|-------------|------|-----|---|--------|
| **B** | cond | 101 | 0 | signed_immed_24 |
| **BL** | cond | 101 | 1 | signed_immed_24 |

#### Load/Store Instructions

| Instruction | Cond | 01 | I | P | U | B | W | L | Rn | Rd | Offset |
|-------------|------|----|---|---|---|---|---|---|---|---|---|--------|
| **LDR** | cond | 01 | I | 1 | U | 0 | 0 | 1 | Rn | Rd | offset |
| **STR** | cond | 01 | I | 1 | U | 0 | 0 | 0 | Rn | Rd | offset |
| **LDRB** | cond | 01 | I | 1 | U | 1 | 0 | 1 | Rn | Rd | offset |
| **STRB** | cond | 01 | I | 1 | U | 1 | 0 | 0 | Rn | Rd | offset |

### ARM64 Instruction Encoding (AArch64)

#### Base Instruction Formats

| Op0 | Op1 | Instruction Class |
|-----|-----|-------------------|
| 00 | x | Unallocated |
| 01 | x | Data processing - immediate |
| 10 | x | Branch, exception, system |
| 11 | 0 | Loads and stores |
| 11 | 1 | Data processing - register |

#### Data Processing - Immediate

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| **ADD (immediate)** | 1000 100x | Add immediate |
| **ADDS (immediate)** | 0010 100x | Add immediate, set flags |
| **SUB (immediate)** | 1101 000x | Subtract immediate |
| **SUBS (immediate)** | 0110 100x | Subtract immediate, set flags |
| **AND (immediate)** | 0001 0000 | Bitwise AND immediate |
| **ORR (immediate)** | 0010 0000 | Bitwise OR immediate |
| **EOR (immediate)** | 0100 0000 | Bitwise XOR immediate |
| **MOVZ** | 1010 0101 | Move wide with zero |
| **MOVK** | 1110 0101 | Move wide with keep |
| **MOVN** | 0000 0101 | Move wide with NOT |

#### Data Processing - Register

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| **ADD (extended register)** | 0000 1011 | Add extended register |
| **ADDS (extended register)** | 0010 1011 | Add extended register, set flags |
| **SUB (extended register)** | 0100 1011 | Subtract extended register |
| **SUBS (extended register)** | 0110 1011 | Subtract extended register, set flags |
| **AND (shifted register)** | 0000 1010 | Bitwise AND shifted register |
| **ORR (shifted register)** | 0010 1010 | Bitwise OR shifted register |
| **EOR (shifted register)** | 0100 1010 | Bitwise XOR shifted register |
| **LSL** | 1101 0011 000 | Logical shift left |
| **LSR** | 1101 0011 001 | Logical shift right |
| **ASR** | 1101 0011 010 | Arithmetic shift right |
| **ROR** | 1101 0011 011 | Rotate right |

#### Load/Store Instructions

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| **STR (immediate)** | 1111 1000 00 | Store register (immediate offset) |
| **LDR (immediate)** | 1111 1000 01 | Load register (immediate offset) |
| **STRB (immediate)** | 0011 1000 00 | Store byte (immediate offset) |
| **LDRB (immediate)** | 0011 1000 01 | Load byte (immediate offset) |
| **STRH (immediate)** | 0111 1000 00 | Store halfword (immediate offset) |
| **LDRH (immediate)** | 0111 1000 01 | Load halfword (immediate offset) |
| **STUR** | 1111 0000 00 | Store register (unscaled offset) |
| **LDUR** | 1111 0000 01 | Load register (unscaled offset) |
| **STP** | 1010 1000 00 | Store pair of registers |
| **LDP** | 1010 1000 01 | Load pair of registers |

#### Branch Instructions

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| **B** | 0001 01 | Branch |
| **BL** | 1001 01 | Branch with link |
| **BR** | 1101 011 | Branch to register |
| **BLR** | 1001 011 | Branch with link to register |
| **RET** | 1101 011 | Return from subroutine |
| **CBZ** | 1011 0100 | Compare and branch on zero |
| **CBNZ** | 1011 0101 | Compare and branch on non-zero |
| **TBZ** | 1011 0110 | Test bit and branch if zero |
| **TBNZ** | 1011 0111 | Test bit and branch if non-zero |

#### System Instructions

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| **SVC** | 1101 0100 000 | Supervisor call |
| **HVC** | 1101 0100 001 | Hypervisor call |
| **SMC** | 1101 0100 010 | Secure monitor call |
| **BRK** | 1101 0100 100 | Breakpoint instruction |
| **HLT** | 1101 0100 101 | Halt instruction |
| **DCPS1/2/3** | 1101 0100 11x | Debug change PE state |

### ARM Condition Codes

| Suffix | Meaning | Condition |
|--------|---------|-----------|
| **EQ** | Equal | Z = 1 |
| **NE** | Not equal | Z = 0 |
| **CS/HS** | Carry set/unsigned higher or same | C = 1 |
| **CC/LO** | Carry clear/unsigned lower | C = 0 |
| **MI** | Minus/negative | N = 1 |
| **PL** | Plus/positive or zero | N = 0 |
| **VS** | Overflow | V = 1 |
| **VC** | No overflow | V = 0 |
| **HI** | Unsigned higher | C = 1 and Z = 0 |
| **LS** | Unsigned lower or same | C = 0 or Z = 1 |
| **GE** | Signed greater than or equal | N = V |
| **LT** | Signed less than | N != V |
| **GT** | Signed greater than | Z = 0 and N = V |
| **LE** | Signed less than or equal | Z = 1 or N != V |
| **AL** | Always (unconditional) | Any |

---

## 🏗️ MIPS Opcodes

### R-Type Instructions (Register)

| Instruction | Opcode | rs | rt | rd | shamt | funct |
|-------------|--------|----|----|----|-------|-------|
| **ADD** | 0x00 | rs | rt | rd | 0 | 0x20 |
| **ADDU** | 0x00 | rs | rt | rd | 0 | 0x21 |
| **SUB** | 0x00 | rs | rt | rd | 0 | 0x22 |
| **SUBU** | 0x00 | rs | rt | rd | 0 | 0x23 |
| **AND** | 0x00 | rs | rt | rd | 0 | 0x24 |
| **OR** | 0x00 | rs | rt | rd | 0 | 0x25 |
| **XOR** | 0x00 | rs | rt | rd | 0 | 0x26 |
| **NOR** | 0x00 | rs | rt | rd | 0 | 0x27 |
| **SLT** | 0x00 | rs | rt | rd | 0 | 0x2A |
| **SLTU** | 0x00 | rs | rt | rd | 0 | 0x2B |
| **SLL** | 0x00 | 0 | rt | rd | shamt | 0x00 |
| **SRL** | 0x00 | 0 | rt | rd | shamt | 0x02 |
| **SRA** | 0x00 | 0 | rt | rd | shamt | 0x03 |
| **SLLV** | 0x00 | rs | rt | rd | 0 | 0x04 |
| **SRLV** | 0x00 | rs | rt | rd | 0 | 0x06 |
| **SRAV** | 0x00 | rs | rt | rd | 0 | 0x07 |
| **JR** | 0x00 | rs | 0 | 0 | 0 | 0x08 |
| **JALR** | 0x00 | rs | 0 | rd | 0 | 0x09 |
| **MOVZ** | 0x00 | rs | rt | rd | 0 | 0x0A |
| **MOVN** | 0x00 | rs | rt | rd | 0 | 0x0B |
| **SYSCALL** | 0x00 | code | 0 | 0 | 0 | 0x0C |
| **BREAK** | 0x00 | code | 0 | 0 | 0 | 0x0D |
| **SYNC** | 0x00 | 0 | 0 | 0 | 0 | 0x0F |
| **MFHI** | 0x00 | 0 | 0 | rd | 0 | 0x10 |
| **MTHI** | 0x00 | rs | 0 | 0 | 0 | 0x11 |
| **MFLO** | 0x00 | 0 | 0 | rd | 0 | 0x12 |
| **MTLO** | 0x00 | rs | 0 | 0 | 0 | 0x13 |
| **MULT** | 0x00 | rs | rt | 0 | 0 | 0x18 |
| **MULTU** | 0x00 | rs | rt | 0 | 0 | 0x19 |
| **DIV** | 0x00 | rs | rt | 0 | 0 | 0x1A |
| **DIVU** | 0x00 | rs | rt | 0 | 0 | 0x1B |

### I-Type Instructions (Immediate)

| Instruction | Opcode | rs | rt | immediate |
|-------------|--------|----|----|-----------|
| **ADDI** | 0x08 | rs | rt | immediate |
| **ADDIU** | 0x09 | rs | rt | immediate |
| **SLTI** | 0x0A | rs | rt | immediate |
| **SLTIU** | 0x0B | rs | rt | immediate |
| **ANDI** | 0x0C | rs | rt | immediate |
| **ORI** | 0x0D | rs | rt | immediate |
| **XORI** | 0x0E | rs | rt | immediate |
| **LUI** | 0x0F | 0 | rt | immediate |
| **BEQ** | 0x04 | rs | rt | offset |
| **BNE** | 0x05 | rs | rt | offset |
| **BLEZ** | 0x06 | rs | 0 | offset |
| **BGTZ** | 0x07 | rs | 0 | offset |
| **BLTZ** | 0x01 | rs | 0 | offset |
| **BGEZ** | 0x01 | rs | 1 | offset |
| **BLTZAL** | 0x01 | rs | 0x10 | offset |
| **BGEZAL** | 0x01 | rs | 0x11 | offset |
| **LB** | 0x20 | base | rt | offset |
| **LH** | 0x21 | base | rt | offset |
| **LWL** | 0x22 | base | rt | offset |
| **LW** | 0x23 | base | rt | offset |
| **LBU** | 0x24 | base | rt | offset |
| **LHU** | 0x25 | base | rt | offset |
| **LWR** | 0x26 | base | rt | offset |
| **SB** | 0x28 | base | rt | offset |
| **SH** | 0x29 | base | rt | offset |
| **SWL** | 0x2A | base | rt | offset |
| **SW** | 0x2B | base | rt | offset |
| **SWR** | 0x2E | base | rt | offset |
| **CACHE** | 0x2F | base | op | offset |
| **LL** | 0x30 | base | rt | offset |
| **LWC1** | 0x31 | base | ft | offset |
| **LWC2** | 0x32 | base | rt | offset |
| **PREF** | 0x33 | base | hint | offset |
| **LDC1** | 0x35 | base | ft | offset |
| **LDC2** | 0x36 | base | rt | offset |
| **SC** | 0x38 | base | rt | offset |
| **SWC1** | 0x39 | base | ft | offset |
| **SWC2** | 0x3A | base | rt | offset |
| **SDC1** | 0x3D | base | ft | offset |
| **SDC2** | 0x3E | base | rt | offset |

### J-Type Instructions (Jump)

| Instruction | Opcode | address |
|-------------|--------|---------|
| **J** | 0x02 | address |
| **JAL** | 0x03 | address |

### Coprocessor Instructions

| Instruction | Format | Description |
|-------------|--------|-------------|
| **MFCz** | COPz | Move from coprocessor |
| **MTCz** | COPz | Move to coprocessor |
| **CFCz** | COPz | Move control from coprocessor |
| **CTCz** | COPz | Move control to coprocessor |
| **LWCz** | COPz | Load word to coprocessor |
| **SWCz** | COPz | Store word from coprocessor |

---

## 🎯 Common Instruction Patterns

### Function Prologue/Epilogue

#### x86/x64
```assembly
; Prologue
55                    push ebp/rbp
89 E5                 mov ebp, esp
48 83 EC 20           sub rsp, 0x20  ; Stack allocation

; Epilogue
48 89 EC              mov rsp, rbp
5D                    pop ebp/rbp
C3                    ret
C2 00 00              ret 0          ; Return with stack cleanup
```

#### ARM64
```assembly
; Prologue
FD 03 00 91           sub sp, sp, #0x10
F3 0F 00 F9           str x19, [sp, #8]
FD 7B 00 A9           stp x29, x30, [sp]
FD 03 00 91           mov x29, sp

; Epilogue
FD 7B 40 A9           ldp x29, x30, [sp]
F3 0F 40 F9           ldr x19, [sp, #8]
FF 03 00 91           add sp, sp, #0x10
C0 03 5F D6           ret
```

#### MIPS
```assembly
; Prologue
27 BD FF C0           addiu sp, sp, -64
AF BF 00 3C           sw ra, 60(sp)
AF BE 00 38           sw fp, 56(sp)
03 A0 F0 21           move fp, sp

; Epilogue
8F BF 00 3C           lw ra, 60(sp)
8F BE 00 38           lw fp, 56(sp)
27 BD 00 40           addiu sp, sp, 64
03 E0 00 08           jr ra
```

### Common Sequences

#### Clear Register
```assembly
; x86/x64
31 C0                 xor eax, eax
48 31 C0              xor rax, rax

; ARM64
3F 00 00 91           mov x0, xzr

; MIPS
00 00 00 00           sll zero, zero, 0  ; (nop)
```

#### Compare and Branch
```assembly
; x86/x64
39 D8                 cmp eax, ebx
74 0A                 je label

; ARM64
EB 00 00 71           cmp x0, x1
54 00 00 0A           b.eq label

; MIPS
00 48 10 26           xor t0, v0, v1
11 00 00 13           beqz t0, label
```

#### Loop Constructs
```assembly
; x86/x64 loop
B9 0A 00 00 00        mov ecx, 10
loop:
48 FF C9              dec rcx
75 FB                 jnz loop

; ARM64 loop
E0 03 0A AA           mov x0, #10
loop:
F1 03 00 AA           mov x1, x0
F1 FF FF 91           sub x1, x1, #1
F0 03 01 AA           mov x0, x1
A0 FF FF B5           cbnz x0, loop
```

---

## 🔤 Opcode Mnemonics

### x86/x64 One-Byte Opcodes

| Opcode | Mnemonic | Opcode | Mnemonic | Opcode | Mnemonic |
|--------|----------|--------|----------|--------|----------|
| 00 | ADD r/m8, r8 | 40-4F | REX prefix | 80 | ADD/OR/ADC/etc r/m8, imm8 |
| 01 | ADD r/m, r | 50 | PUSH RAX | 81 | ADD/OR/ADC/etc r/m, imm |
| 02 | ADD r8, r/m8 | 51 | PUSH RCX | 82 | (invalid) |
| 03 | ADD r, r/m | 52 | PUSH RDX | 83 | ADD/OR/ADC/etc r/m, imm8 |
| 04 | ADD AL, imm8 | 53 | PUSH RBX | 84 | TEST r/m8, r8 |
| 05 | ADD RAX, imm | 54 | PUSH RSP | 85 | TEST r/m, r |
| 06 | PUSH ES | 55 | PUSH RBP | 86 | XCHG r/m8, r8 |
| 07 | POP ES | 56 | PUSH RSI | 87 | XCHG r/m, r |
| 08 | OR r/m8, r8 | 57 | PUSH RDI | 88 | MOV r/m8, r8 |
| 09 | OR r/m, r | 58 | POP RAX | 89 | MOV r/m, r |
| 0A | OR r8, r/m8 | 59 | POP RCX | 8A | MOV r8, r/m8 |
| 0B | OR r, r/m | 5A | POP RDX | 8B | MOV r, r/m |
| 0C | OR AL, imm8 | 5B | POP RBX | 8C | MOV r/m, Sreg |
| 0D | OR RAX, imm | 5C | POP RSP | 8D | LEA r, m |
| 0E | PUSH CS | 5D | POP RBP | 8E | MOV Sreg, r/m |
| 0F | Two-byte opcode | 5E | POP RSI | 8F | POP r/m |
| 10 | ADC r/m8, r8 | 5F | POP RDI | 90 | NOP/XCHG RAX, RAX |
| 11 | ADC r/m, r | 60 | PUSHAD | 91 | XCHG RCX, RAX |
| 12 | ADC r8, r/m8 | 61 | POPAD | 92 | XCHG RDX, RAX |
| 13 | ADC r, r/m | 62 | BOUND | 93 | XCHG RBX, RAX |
| 14 | ADC AL, imm8 | 63 | MOVSXD | 94 | XCHG RSP, RAX |
| 15 | ADC RAX, imm | 64 | FS prefix | 95 | XCHG RBP, RAX |
| 16 | PUSH SS | 65 | GS prefix | 96 | XCHG RSI, RAX |
| 17 | POP SS | 66 | Operand size | 97 | XCHG RDI, RAX |
| 18 | SBB r/m8, r8 | 67 | Address size | 98 | CBW/CWDE/CDQE |
| 19 | SBB r/m, r | 68 | PUSH imm | 99 | CWD/CDQ/CQO |
| 1A | SBB r8, r/m8 | 69 | IMUL r, r/m, imm | 9A | CALL far |
| 1B | SBB r, r/m | 6A | PUSH imm8 | 9B | WAIT/FWAIT |
| 1C | SBB AL, imm8 | 6B | IMUL r, r/m, imm8 | 9C | PUSHF/PUSHFD |
| 1D | SBB RAX, imm | 6C | INS m8, DX | 9D | POPF/POPFD |
| 1E | PUSH DS | 6D | INS m, DX | 9E | SAHF |
| 1F | POP DS | 6E | OUTS DX, m8 | 9F | LAHF |
| 20 | AND r/m8, r8 | 6F | OUTS DX, m | A0 | MOV AL, moffs |
| 21 | AND r/m, r | 70 | JO rel8 | A1 | MOV RAX, moffs |
| 22 | AND r8, r/m8 | 71 | JNO rel8 | A2 | MOV moffs, AL |
| 23 | AND r, r/m | 72 | JB/JC/JNAE rel8 | A3 | MOV moffs, RAX |
| 24 | AND AL, imm8 | 73 | JNB/JNC/JAE rel8 | A4 | MOVSB |
| 25 | AND RAX, imm | 74 | JZ/JE rel8 | A5 | MOVSW/MOVSD |
| 26 | ES prefix | 75 | JNZ/JNE rel8 | A6 | CMPSB |
| 27 | DAA | 76 | JBE/JNA rel8 | A7 | CMPSW/CMPSD |
| 28 | SUB r/m8, r8 | 77 | JNBE/JA rel8 | A8 | TEST AL, imm8 |
| 29 | SUB r/m, r | 78 | JS rel8 | A9 | TEST RAX, imm |
| 2A | SUB r8, r/m8 | 79 | JNS rel8 | AA | STOSB |
| 2B | SUB r, r/m | 7A | JP/JPE rel8 | AB | STOSW/STOSD |
| 2C | SUB AL, imm8 | 7B | JNP/JPO rel8 | AC | LODSB |
| 2D | SUB RAX, imm | 7C | JL/JNGE rel8 | AD | LODSW/LODSD |
| 2E | CS prefix | 7D | JNL/JGE rel8 | AE | SCASB |
| 2F | DAS | 7E | JLE/JNG rel8 | AF | SCASW/SCASD |
| 30 | XOR r/m8, r8 | 7F | JNLE/JG rel8 | B0 | MOV AL, imm8 |
| 31 | XOR r/m, r | 80 | ADD/OR/ADC/etc r/m8, imm8 | B1 | MOV CL, imm8 |
| 32 | XOR r8, r/m8 | 81 | ADD/OR/ADC/etc r/m, imm | B2 | MOV DL, imm8 |
| 33 | XOR r, r/m | 82 | (invalid) | B3 | MOV BL, imm8 |
| 34 | XOR AL, imm8 | 83 | ADD/OR/ADC/etc r/m, imm8 | B4 | MOV AH, imm8 |
| 35 | XOR RAX, imm | 84 | TEST r/m8, r8 | B5 | MOV CH, imm8 |
| 36 | SS prefix | 85 | TEST r/m, r | B6 | MOV DH, imm8 |
| 37 | AAA | 86 | XCHG r/m8, r8 | B7 | MOV BH, imm8 |
| 38 | CMP r/m8, r8 | 87 | XCHG r/m, r | B8 | MOV RAX, imm |
| 39 | CMP r/m, r | 88 | MOV r/m8, r8 | B9 | MOV RCX, imm |
| 3A | CMP r8, r/m8 | 89 | MOV r/m, r | BA | MOV RDX, imm |
| 3B | CMP r, r/m | 8A | MOV r8, r/m8 | BB | MOV RBX, imm |
| 3C | CMP AL, imm8 | 8B | MOV r, r/m | BC | MOV RSP, imm |
| 3D | CMP RAX, imm | 8C | MOV r/m, Sreg | BD | MOV RBP, imm |
| 3E | DS prefix | 8D | LEA r, m | BE | MOV RSI, imm |
| 3F | AAS | 8E | MOV Sreg, r/m | BF | MOV RDI, imm |

### Common Two-Byte Opcodes (0F xx)

| 0F xx | Mnemonic | 0F xx | Mnemonic | 0F xx | Mnemonic |
|-------|----------|-------|----------|-------|----------|
| 00 | SLDT/STR/LLDT/etc | 80 | JO rel32 | A0 | PUSH FS |
| 01 | SGDT/SIDT/LGDT/etc | 81 | JNO rel32 | A1 | POP FS |
| 02 | LAR | 82 | JB/JC/JNAE rel32 | A2 | CPUID |
| 03 | LSL | 83 | JNB/JNC/JAE rel32 | A3 | BT r/m, r |
| 05 | SYSCALL | 84 | JZ/JE rel32 | A4 | SHLD r/m, r, imm8 |
| 06 | CLTS | 85 | JNZ/JNE rel32 | A5 | SHLD r/m, r, CL |
| 08 | INVD | 86 | JBE/JNA rel32 | A8 | PUSH GS |
| 09 | WBINVD | 87 | JNBE/JA rel32 | A9 | POP GS |
| 0B | UD2 | 88 | JS rel32 | AA | RSM |
| 10 | MOVUPS | 89 | JNS rel32 | AB | BTS r/m, r |
| 11 | MOVUPS | 8A | JP/JPE rel32 | AC | SHRD r/m, r, imm8 |
| 12 | MOVLPS/MOVHLPS | 8B | JNP/JPO rel32 | AD | SHRD r/m, r, CL |
| 13 | MOVLPS | 8C | JL/JNGE rel32 | AE | LFENCE/SFENCE/MFENCE |
| 14 | UNPCKLPS | 8D | JNL/JGE rel32 | AF | IMUL r, r/m |
| 15 | UNPCKHPS | 8E | JLE/JNG rel32 | B0 | CMPXCHG r/m8, r8 |
| 16 | MOVHPS | 8F | JNLE/JG rel32 | B1 | CMPXCHG r/m, r |
| 17 | MOVHPS | 90 | SETO r/m8 | B2 | LSS |
| 18 | PREFETCH | 91 | SETNO r/m8 | B3 | BTR r/m, r |
| 1F | NOP | 92 | SETB/SETC/SETNAE r/m8 | B4 | LFS |
| 20 | MOV r, CRn | 93 | SETNB/SETNC/SETAE r/m8 | B5 | LGS |
| 21 | MOV r, DRn | 94 | SETZ/SETE r/m8 | B6 | MOVZX r, r/m8 |
| 22 | MOV CRn, r | 95 | SETNZ/SETNE r/m8 | B7 | MOVZX r, r/m16 |
| 23 | MOV DRn, r | 96 | SETBE/SETNA r/m8 | B8 | POPCNT |
| 28 | MOVAPS | 97 | SETNBE/SETA r/m8 | B9 | (undefined) |
| 29 | MOVAPS | 98 | SETS r/m8 | BA | BT/BTS/BTR/BTC r/m, imm8 |
| 2A | CVTPI2PS/CVTSI2SS | 99 | SETNS r/m8 | BB | BTC r/m, r |
| 2B | MOVNTPS | 9A | SETP/SETPE r/m8 | BC | BSF r, r/m |
| 2C | CVTTPS2PI/CVTTSS2SI | 9B | SETNP/SETPO r/m8 | BD | BSR r, r/m |
| 2D | CVTPS2PI/CVTSS2SI | 9C | SETL/SETNGE r/m8 | BE | MOVSX r, r/m8 |
| 2E | UCOMISS | 9D | SETNL/SETGE r/m8 | BF | MOVSX r, r/m16 |
| 2F | COMISS | 9E | SETLE/SETNG r/m8 | C0 | XADD r/m8, r8 |
| 30 | WRMSR | 9F | SETNLE/SETG r/m8 | C1 | XADD r/m, r |
| 31 | RDTSC | A0 | PUSH FS | C2 | CMPPS |
| 32 | RDMSR | A1 | POP FS | C3 | MOVNTI |
| 33 | RDPMC | A2 | CPUID | C4 | PINSRW |
| 34 | SYSENTER | A3 | BT r/m, r | C5 | PEXTRW |
| 35 | SYSEXIT | A4 | SHLD r/m, r, imm8 | C6 | SHUFPS |
| 40 | CMOVO r, r/m | A5 | SHLD r/m, r, CL | C7 | (Group 9/11) |
| 41 | CMOVNO r, r/m | A8 | PUSH GS | C8 | BSWAP RAX |
| 42 | CMOVB/CMOVC/CMOVNAE r, r/m | A9 | POP GS | C9 | BSWAP RCX |
| 43 | CMOVNB/CMOVNC/CMOVAE r, r/m | AA | RSM | CA | BSWAP RDX |
| 44 | CMOVZ/CMOVE r, r/m | AB | BTS r/m, r | CB | BSWAP RBX |
| 45 | CMOVNZ/CMOVNE r, r/m | AC | SHRD r/m, r, imm8 | CC | BSWAP RSP |
| 46 | CMOVBE/CMOVNA r, r/m | AD | SHRD r/m, r, CL | CD | BSWAP RBP |
| 47 | CMOVNBE/CMOVA r, r/m | AE | LFENCE/SFENCE/MFENCE | CE | BSWAP RSI |
| 48 | CMOVS r, r/m | AF | IMUL r, r/m | CF | BSWAP RDI |
| 49 | CMOVNS r, r/m | B0 | CMPXCHG r/m8, r8 | D0 | ADDSUBPS |
| 4A | CMOVP/CMOVPE r, r/m | B1 | CMPXCHG r/m, r | D1 | PSRLW |
| 4B | CMOVNP/CMOVPO r, r/m | B2 | LSS | D2 | PSRLD |
| 4C | CMOVL/CMOVNGE r, r/m | B3 | BTR r/m, r | D3 | PSRLQ |
| 4D | CMOVNL/CMOVGE r, r/m | B4 | LFS | D4 | PADDQ |
| 4E | CMOVLE/CMOVNG r, r/m | B5 | LGS | D5 | PMULLW |
| 4F | CMOVNLE/CMOVG r, r/m | B6 | MOVZX r, r/m8 | D6 | MOVQ |
| 50 | MOVMSKPS | B7 | MOVZX r, r/m16 | D7 | PMOVMSKB |
| 51 | SQRTPS | B8 | POPCNT | D8 | PSUBUSB |
| 52 | RSQRTPS | B9 | (undefined) | D9 | PSUBUSW |
| 53 | RCPPS | BA | BT/BTS/BTR/BTC r/m, imm8 | DA | PMINUB |
| 54 | ANDPS | BB | BTC r/m, r | DB | PAND |
| 55 | ANDNPS | BC | BSF r, r/m | DC | PADDUSB |
| 56 | ORPS | BD | BSR r, r/m | DD | PADDUSW |
| 57 | XORPS | BE | MOVSX r, r/m8 | DE | PMAXUB |
| 58 | ADDPS | BF | MOVSX r, r/m16 | DF | PANDN |
| 59 | MULPS | C0 | XADD r/m8, r8 | E0 | PAVGB |
| 5A | CVTPS2PD | C1 | XADD r/m, r | E1 | PSRAW |
| 5B | CVTDQ2PS | C2 | CMPPS | E2 | PSRAD |
| 5C | SUBPS | C3 | MOVNTI | E3 | PAVGW |
| 5D | MINPS | C4 | PINSRW | E4 | PMULHUW |
| 5E | DIVPS | C5 | PEXTRW | E5 | PMULHW |
| 5F | MAXPS | C6 | SHUFPS | E6 | CVTTPD2DQ |
| 60 | PUNPCKLBW | C7 | (Group 9/11) | E7 | MOVNTDQ |
| 61 | PUNPCKLWD | C8 | BSWAP RAX | E8 | PSUBSB |
| 62 | PUNPCKLDQ | C9 | BSWAP RCX | E9 | PSUBSW |
| 63 | PACKSSWB | CA | BSWAP RDX | EA | PMINSW |
| 64 | PCMPGTB | CB | BSWAP RBX | EB | POR |
| 65 | PCMPGTW | CC | BSWAP RSP | EC | PADDSB |
| 66 | PCMPGTD | CD | BSWAP RBP | ED | PADDSW |
| 67 | PACKUSWB | CE | BSWAP RSI | EE | PMAXSW |
| 68 | PUNPCKHBW | CF | BSWAP RDI | EF | PXOR |
| 69 | PUNPCKHWD | D0 | ADDSUBPS | F0 | LDDQU |
| 6A | PUNPCKHDQ | D1 | PSRLW | F1 | PSLLW |
| 6B | PACKSSDW | D2 | PSRLD | F2 | PSLLD |
| 6C | PUNPCKLQDQ | D3 | PSRLQ | F3 | PSLLQ |
| 6D | PUNPCKHQDQ | D4 | PADDQ | F4 | PMULUDQ |
| 6E | MOVD/MOVQ | D5 | PMULLW | F5 | PMADDWD |
| 6F | MOVDQA | D6 | MOVQ | F6 | PSADBW |
| 70 | PSHUFW | D7 | PMOVMSKB | F7 | MASKMOVQ |
| 71 | PSRLW/PSRAW/PSLLW | D8 | PSUBUSB | F8 | PSUBB |
| 72 | PSRLD/PSRAD/PSLLD | D9 | PSUBUSW | F9 | PSUBW |
| 73 | PSRLQ/PSLLQ | DA | PMINUB | FA | PSUBD |
| 74 | PCMPEQB | DB | PAND | FB | PSUBQ |
| 75 | PCMPEQW | DC | PADDUSB | FC | PADDB |
| 76 | PCMPEQD | DD | PADDUSW | FD | PADDW |
| 77 | EMMS | DE | PMAXUB | FE | PADDD |
| 78 | (VMREAD) | DF | PANDN | FF | (Group 5) |
| 79 | (VMWRITE) | E0 | PAVGB | | |

---

## 🔧 Encoding Reference

### x86/x64 ModR/M Byte

```
7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+
|  Mod  |    Reg    |    R/M    |
+---+---+---+---+---+---+---+---+

Mod field:
00 - [r/m] or disp0
01 - [r/m]+disp8
10 - [r/m]+disp32
11 - r/m is register

Register encodings (16/32/64-bit):
000 - AX/EAX/RAX
001 - CX/ECX/RCX
010 - DX/EDX/RDX
011 - BX/EBX/RBX
100 - SP/ESP/RSP
101 - BP/EBP/RBP
110 - SI/ESI/RSI
111 - DI/EDI/RDI

R/M encodings (16-bit mode):
000 - [BX+SI]
001 - [BX+DI]
010 - [BP+SI]
011 - [BP+DI]
100 - [SI]
101 - [DI]
110 - disp16 (if Mod=00), [BP] (otherwise)
111 - [BX]

R/M encodings (32/64-bit):
000 - [RAX] or [EAX]
001 - [RCX] or [ECX]
010 - [RDX] or [EDX]
011 - [RBX] or [EBX]
100 - SIB byte follows
101 - [RBP] or [EBP] or disp32 (if Mod=00)
110 - [RSI] or [ESI]
111 - [RDI] or [EDI]
```

### SIB (Scale Index Base) Byte

```
7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+
| Scale |   Index   |   Base    |
+---+---+---+---+---+---+---+---+

Scale field:
00 - *1
01 - *2
10 - *4
11 - *8

Index field: Register number (same as Reg field)
Base field: Register number (same as Reg field)
Special case: Index=100 means no index
```

### ARM Condition Field

```
31  30  29  28
+---+---+---+---+
| cond         |
+---+---+---+---+

Condition codes:
0000 - EQ (equal)
0001 - NE (not equal)
0010 - CS/HS (carry set/unsigned higher or same)
0011 - CC/LO (carry clear/unsigned lower)
0100 - MI (minus/negative)
0101 - PL (plus/positive or zero)
0110 - VS (overflow)
0111 - VC (no overflow)
1000 - HI (unsigned higher)
1001 - LS (unsigned lower or same)
1010 - GE (signed greater or equal)
1011 - LT (signed less than)
1100 - GT (signed greater than)
1101 - LE (signed less or equal)
1110 - AL (always)
1111 - NV (never)
```

### MIPS Instruction Formats

#### R-Type
```
31  26  25  21  20  16  15  11  10   6   5     0
+------+------+------+------+------+------+
| op   | rs   | rt   | rd   | shamt| funct|
+------+------+------+------+------+------+
6 bits 5 bits 5 bits 5 bits 5 bits 6 bits
```

#### I-Type
```
31  26  25  21  20  16  15               0
+------+------+------+-------------------+
| op   | rs   | rt   | immediate         |
+------+------+------+-------------------+
6 bits 5 bits 5 bits       16 bits
```

#### J-Type
```
31  26  25                                0
+------+----------------------------------+
| op   | address                          |
+------+----------------------------------+
6 bits             26 bits
```

---

## 📊 Quick Reference Tables

### Common x86 Opcode Patterns

| Pattern | Likely Instruction |
|---------|-------------------|
| 55 48 89 E5 | push rbp; mov rbp, rsp |
| 48 83 EC ?? | sub rsp, imm8 |
| 48 89 7D ?? | mov [rbp+disp], rdi |
| 8B 45 ?? | mov eax, [rbp+disp] |
| 89 45 ?? | mov [rbp+disp], eax |
| C7 45 ?? ?? ?? ?? ?? | mov dword [rbp+disp], imm32 |
| E8 ?? ?? ?? ?? | call rel32 |
| FF 15 ?? ?? ?? ?? | call [rip+disp32] |
| 48 8B 05 ?? ?? ?? ?? | mov rax, [rip+disp32] |
| 0F 1F 40 00 | nop dword [rax+0] |
| 90 | nop |
| C3 | ret |
| C2 ?? ?? | ret imm16 |
| CC | int3 |

### Common ARM64 Opcode Patterns

| Pattern | Likely Instruction |
|---------|-------------------|
| FD 7B BF A9 | stp x29, x30, [sp, #-16]! |
| FD 03 00 91 | mov x29, sp |
| F3 0F 1F F8 | str x19, [sp, #-16]! |
| 08 00 80 D2 | mov x8, #0 |
| A8 03 1F F8 | stur x8, [x29, #-16] |
| E0 03 13 AA | mov x0, x19 |
| 08 00 80 52 | mov w8, #0 |
| 1F 20 03 D5 | nop |
| C0 03 5F D6 | ret |

### Common MIPS Opcode Patterns

| Pattern | Likely Instruction |
|---------|-------------------|
| 27 BD FF ?? | addiu sp, sp, -imm |
| AF BF ?? ?? | sw ra, offset(sp) |
| 00 00 00 00 | nop (sll zero, zero, 0) |
| 03 E0 00 08 | jr ra |
| 08 00 00 01 | j target |
| 0C 00 00 01 | jal target |

### Shellcode Byte Patterns

| Pattern | Architecture | Description |
|---------|--------------|-------------|
| 31 C0 50 68 2F 2F 73 68 | x86 | execve("/bin/sh") |
| 48 31 D2 48 BB 2F 2F 62 | x64 | execve("/bin/sh") |
| 6A 0B 58 99 52 68 2F 2F | x86 | execve("/bin/sh") alternative |
| 90 90 90 90 90 90 90 90 | Any | NOP sled |
| CC CC CC CC CC CC CC CC | Any | INT3 sled (breakpoints) |

---

## 🎯 Usage Examples

### Finding Functions by Opcode Patterns

```python
def find_functions(binary_data):
    patterns = {
        'function_start_x64': b'\x55\x48\x89\xe5',  # push rbp; mov rbp, rsp
        'function_start_x86': b'\x55\x89\xe5',      # push ebp; mov ebp, esp
        'function_start_arm64': b'\xfd\x7b\xbf\xa9', # stp x29, x30, [sp, #-16]!
        'function_end_ret': b'\xc3',                # ret
        'function_end_iret': b'\xcf',               # iret
    }
    
    results = {}
    for name, pattern in patterns.items():
        offset = 0
        while True:
            pos = binary_data.find(pattern, offset)
            if pos == -1:
                break
            results.setdefault(pos, []).append(name)
            offset = pos + 1
    
    return results
```

### Opcode Analysis Script

```python
def analyze_opcodes(data):
    from capstone import Cs, CS_ARCH_X86, CS_MODE_64
    
    md = Cs(CS_ARCH_X86, CS_MODE_64)
    
    stats = {}
    for insn in md.disasm(data, 0x1000):
        opcode = insn.bytes[0] if insn.bytes else 0
        
        if opcode not in stats:
            stats[opcode] = {
                'count': 0,
                'mnemonics': set(),
                'examples': []
            }
        
        stats[opcode]['count'] += 1
        stats[opcode]['mnemonics'].add(insn.mnemonic)
        
        if len(stats[opcode]['examples']) < 3:
            stats[opcode]['examples'].append({
                'address': insn.address,
                'bytes': insn.bytes.hex(),
                'mnemonic': insn.mnemonic,
                'op_str': insn.op_str
            })
    
    return stats
```

---

**Note**: This reference is meant as a quick lookup. For complete specifications, refer to:
- Intel® 64 and IA-32 Architectures Software Developer's Manual
- ARM Architecture Reference Manual
- MIPS Architecture For Programmers

*Last Updated: 2024*
```

This completes the comprehensive documentation directory with:
1. **Cheat sheets** for x86/x64, ARM/ARM64, and MIPS architectures
2. **Tutorials** covering basic and advanced reverse engineering techniques
3. **References** including research papers, tools/resources, and opcode tables

