# Windows11-MaxPrivacyBat
Maximal privacy setup for Windows 11 using a one-click batch script.

## Features

- Stops and disables telemetry services (`DiagTrack`, `dmwappushservice`)
- Disables Cortana, ads, and system suggestions
- Denies apps access to **microphone, camera, and location**
- Blocks known Microsoft telemetry servers in the **hosts file**
- Disables **Web Search** and **Timeline**
- Blocks **Office telemetry**
- Automatically restarts **Explorer** to apply changes
- Shows `[OK]`, `[FAILED]` or `[INFO]` messages for each step

## Usage

1. Download `Windows11_MaxPrivacy.bat`.
2. **Run as Administrator**.
3. Follow the on-screen instructions.
4. Restart Explorer or the PC if necessary.

> ⚠️ Warning: This script modifies the registry, hosts file, and disables services. Use at your own risk. It is recommended to backup your system before running.

## Notes

- **Windows Update Medic Service (WaaSMedicSvc)** cannot be fully disabled – it is protected by Windows.
- This script does not block all Windows 11 telemetry, but **significantly reduces tracking and telemetry**.
- Works best on **Windows 11 Pro / Enterprise**.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
