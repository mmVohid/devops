# Vohid TOOLKIT

![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-0078D6?logo=windows&logoColor=white)
![Language](https://img.shields.io/badge/script-Batch-4EAA25)
![UI](https://img.shields.io/badge/UI-UZ%20%7C%20EN-blue)

Windows tizimini boshqarish va DevOps vazifalarini tezlashtirish uchun mo'ljallangan, bitta faylli CLI yordamchi.

A lightweight single-file CLI toolkit for Windows system administration and DevOps tasks.


**Tillar / Languages:** [O'zbekcha](#ozbekcha) | [English](#english)

---

## O'zbekcha

### Imkoniyatlar

| №  | Amal | Tavsif |
|----|------|--------|
| 1  | Terminal (CMD) | Administrator huquqidagi CMD oynasini ochadi |
| 2  | PowerShell | Administrator huquqidagi PowerShell oynasini ochadi |
| 3  | Environment Variables (PATH) | Muhit o'zgaruvchilari oynasini to'g'ridan-to'g'ri ochadi |
| 4  | Device Manager | Qurilmalar dispetcherini ochadi |
| 5  | Tizimni skanerlash va tuzatish | Avval `DISM`, keyin `SFC` ishga tushadi, log joyi ko'rsatiladi |
| 6  | Windows aktivatsiya holati | Aktivatsiya holatini ko'rsatadi va Sozlamalarning aktivatsiya sahifasini ochishni taklif qiladi |
| 7  | BIOS (UEFI) ga qayta yoqish | Tasdiqdan so'ng 10 soniyada UEFI sozlamalariga qayta yoqadi |
| 8  | Kompyuterni o'chirish | Tasdiqdan so'ng 30 soniyada o'chiradi, `C` tugmasi bilan bekor qilinadi |
| 9  | Dasturlarni yangilash | `winget` orqali barcha dasturlarni yangilaydi |
| 10 | Band portni yopish | Port raqami bo'yicha tinglayotgan jarayonni topib, tasdiqdan so'ng to'xtatadi |
| A  | Haqida | Loyiha va muallif haqida ma'lumot |
| L  | Til | O'zbekcha / English, tanlov saqlanadi |
| 0  | Chiqish | Dasturdan chiqadi |

### Xavfsizlik

- **Qayta yoqish va o'chirish** (7, 8) tasdiq so'raydi. Tasdiqlash savolida Enter bosilsa, javob "yo'q" hisoblanmaydi, faqat `Y` yoki `N` qabul qilinadi.
- **Bekor qilish:** 7 va 8 bandlarida taymer davomida `C` tugmasi buyruqni to'xtatadi (`shutdown /a`).
- **Port yopish** (10): faqat raqam qabul qilinadi, faqat `LISTEN` holatidagi jarayonlar ko'rsatiladi, tizim jarayonlari (PID 0 va 4) tegilmaydi va to'xtatishdan oldin tasdiq so'raladi.

### Talablar

- Windows 10 yoki Windows 11 (rangli interfeys ANSI qo'llab-quvvatlashiga tayanadi)
- Administrator huquqi. Fayl o'zini avtomatik ravishda admin sifatida qayta ishga tushiradi (UAC oynasi chiqadi)
- PowerShell, 10-band uchun (`Get-NetTCPConnection`)
- [`winget`](https://learn.microsoft.com/windows/package-manager/) (App Installer), 9-band uchun
- UEFI qo'llab-quvvatlovchi tizim, 7-band uchun

### O'rnatish va ishga tushirish

1. Repozitoriyni yuklab oling:

   ```bat
   git clone https://github.com/mnmbackend/<repo-nomi>.git
   cd <repo-nomi>
   ```

   yoki **Code → Download ZIP** orqali yuklab, arxivdan chiqaring.

2. `TOOLKIT.bat` faylini ikki marta bosing. UAC so'raganda **Yes** ni tanlang.

O'rnatish talab qilinmaydi: butun dastur bitta `.bat` faylda.

### Sozlamalar

Tanlangan til quyidagi faylda saqlanadi:

```
%LOCALAPPDATA%\VohidToolkit.lang
```

Faylni o'chirsangiz, dastur keyingi ishga tushishda o'zbekcha boshlanadi.

### Yangi til qo'shish

Barcha matnlar faylning oxiridagi `:LANG_UZ` va `:LANG_EN` bo'limlarida turadi. Yangi til uchun `:LANG_XX` bo'limini nusxalab, qiymatlarni tarjima qiling va `T_LANG` bo'limiga tanlov qo'shing.

### Ogohlantirish

Dastur tizim darajasidagi amallarni administrator huquqi bilan bajaradi. Ishlatishdan oldin fayl mazmunini o'qib chiqing va saqlanmagan ishlaringizni saqlab oling. Muallif dasturdan foydalanish oqibatlari uchun javobgar emas.

---

## English

### Features

| #  | Action | Description |
|----|--------|-------------|
| 1  | Terminal (CMD) | Opens an elevated CMD window |
| 2  | PowerShell | Opens an elevated PowerShell window |
| 3  | Environment Variables (PATH) | Opens the environment variables dialog directly |
| 4  | Device Manager | Opens Device Manager |
| 5  | System scan and repair | Runs `DISM` first, then `SFC`, and shows where the log is |
| 6  | Windows activation status | Shows the activation state and offers to open the Settings activation page |
| 7  | Reboot to BIOS (UEFI) | After confirmation, reboots into UEFI setup in 10 seconds |
| 8  | Shutdown computer | After confirmation, shuts down in 30 seconds, cancellable with `C` |
| 9  | Update all software | Upgrades all installed apps through `winget` |
| 10 | Force kill busy port | Finds the process listening on a port and stops it after confirmation |
| A  | About | Project and author info |
| L  | Language | Uzbek / English, the choice is remembered |
| 0  | Exit | Quits the toolkit |

### Safety

- **Reboot and shutdown** (7, 8) ask for confirmation, and only `Y` or `N` is accepted, so pressing Enter never confirms by accident.
- **Cancel:** during the countdown of items 7 and 8, press `C` to abort (`shutdown /a`).
- **Kill port** (10): digits only, only `LISTEN` processes are listed, system processes (PID 0 and 4) are never touched, and confirmation is required before stopping anything.

### Requirements

- Windows 10 or Windows 11 (the colored UI relies on ANSI support)
- Administrator rights. The script re-launches itself elevated and shows a UAC prompt
- PowerShell, for item 10 (`Get-NetTCPConnection`)
- [`winget`](https://learn.microsoft.com/windows/package-manager/) (App Installer), for item 9
- A UEFI-capable system, for item 7

### Installation and usage

1. Get the repository:

   ```bat
   git clone https://github.com/mnmbackend/<repo-name>.git
   cd <repo-name>
   ```

   or use **Code → Download ZIP** and extract it.

2. Double-click `TOOLKIT.bat` and accept the UAC prompt.

There is nothing to install: the whole tool is a single `.bat` file.

### Configuration

The selected language is stored in:

```
%LOCALAPPDATA%\VohidToolkit.lang
```

Delete this file to reset the language to Uzbek on the next launch.

### Adding a language

All strings live in the `:LANG_UZ` and `:LANG_EN` sections at the end of the script. To add a language, copy one of them as `:LANG_XX`, translate the values, and add the option to the `T_LANG` section.

### Disclaimer

This tool performs system-level actions with administrator rights. Read the script before running it and save your work first. The author is not responsible for any consequences of its use.

---

## Muallif / Author

**Muhammadamin Vohid**

- Gmail: [mnmbackend@gmail.com](mailto:mnmbackend@gmail.com)
- GitHub: [github.com/mnmbackend](https://github.com/mnmbackend)
