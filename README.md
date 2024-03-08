# SuperCollider Setup

My work in progress basic live coding setup.

## Installation

1. Open the sclang startup file:

```
Document.open(Platform.userConfigDir.catArgs("/startup.scd"));
```

2. Add the path to your setup file:

```
(SETUP_FILE_PATH.standardizePath).load;
```

3. Install these quarks:

- ddwSnippets
- miSCellaneousLib
