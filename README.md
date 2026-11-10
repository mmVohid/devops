# Vohid TOOLKIT

![Release](https://img.shields.io/github/v/release/mmVohid/devops?color=4EAA25)
![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-0078D6?logo=windows&logoColor=white)
![Script](https://img.shields.io/badge/script-Batch-4EAA25)
![UI](https://img.shields.io/badge/UI-UZ%20%7C%20EN-blue)

Windows tizimini boshqarish va DevOps vazifalari uchun bitta faylli CLI yordamchi.
A single-file CLI toolkit for Windows administration and DevOps tasks.

[![Yuklab olish / Download](https://img.shields.io/badge/⬇_Yuklab_olish_/_Download-TOOLKIT.bat-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://github.com/mmVohid/devops/releases/latest/download/TOOLKIT.bat)

## Imkoniyatlar / Features

| №  | O'zbekcha | English |
|----|-----------|---------|
| 1  | Terminal (CMD), admin | Elevated CMD |
| 2  | PowerShell, admin | Elevated PowerShell |
| 3  | Environment Variables (PATH) | Environment variables dialog |
| 4  | Device Manager | Device Manager |
| 5  | Tizimni skanerlash va tuzatish (DISM, keyin SFC) | System scan and repair (DISM, then SFC) |
| 6  | Windows aktivatsiya holati | Windows activation status |
| 7  | BIOS (UEFI) ga qayta yoqish, 10 soniya | Reboot to BIOS (UEFI), 10 s |
| 8  | Kompyuterni o'chirish, 30 soniya | Shutdown, 30 s |
| 9  | Barcha dasturlarni yangilash (`winget`) | Update all software (`winget`) |
| 10 | Band portni majburiy yopish | Force kill busy port |
| A / L / 0 | Haqida / Til / Chiqish | About / Language / Exit |

## Xavfsizlik / Safety

- **7, 8:** tasdiq so'raydi (faqat `Y` / `N`), taymer davomida `C` bilan bekor qilinadi.
  Confirmation required (`Y` / `N` only), press `C` during the countdown to cancel.
- **10:** faqat raqam, faqat `LISTEN` jarayonlari, tizim jarayonlari (PID 0 va 4) tegilmaydi, to'xtatishdan oldin tasdiq so'raladi.
  Digits only, `LISTEN` processes only, system PIDs 0 and 4 are skipped, confirmation before stopping.

## Talablar / Requirements

- Windows 10 / 11 (rangli interfeys ANSI ga tayanadi / colored UI needs ANSI)
- Administrator huquqi: fayl o'zini admin sifatida qayta ishga tushiradi (UAC) / the script re-launches itself elevated (UAC)
- 9-band uchun [`winget`](https://learn.microsoft.com/windows/package-manager/), 7-band uchun UEFI / `winget` for item 9, UEFI for item 7

## Ishga tushirish / Usage

1. **Yuklab olish** tugmasini bosing yoki / Click **Download**, or:

   ```powershell
   irm https://github.com/mmVohid/devops/releases/latest/download/TOOLKIT.bat -OutFile TOOLKIT.bat
   ```

2. `TOOLKIT.bat` ni ikki marta bosing va UAC da **Yes** ni tanlang / Double-click it and accept the UAC prompt.

Til tanlovi `%LOCALAPPDATA%\VohidToolkit.lang` faylida saqlanadi. Yangi til qo'shish uchun `:LANG_UZ` bo'limini `:LANG_XX` sifatida nusxalab, tarjima qiling va `T_LANG` ga tanlov qo'shing.
The language choice is stored in that file. To add a language, copy `:LANG_UZ` as `:LANG_XX`, translate it, and add an option in `T_LANG`.

## Ogohlantirish / Disclaimer

Dastur tizim darajasidagi amallarni admin huquqi bilan bajaradi. Ishlatishdan oldin faylni o'qib chiqing va ishlaringizni saqlang. Muallif oqibatlar uchun javobgar emas.
This tool performs system-level actions as administrator. Read the script first and save your work. The author is not liable for any consequences.

## Muallif / Author

**Muhammadamin Vohid** · [mnmbackend@gmail.com](mailto:mnmbackend@gmail.com) · [github.com/mmVohid](https://github.com/mmVohid)
