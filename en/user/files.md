---
source: RedmineFiles
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineFiles
source_version: 10
source_updated_on: '2021-02-04T00:38:12Z'
updated_for: 7.0.3
---

# Redmine Files

## Files Module

Each project can have a **Files** module enabled/disabled via the settings menu.

A sortable table shows the details of all the uploaded files. If a version if selected while uploading a file, that file will be shown below the version. Of note are the Checksum hash and D/L(Download Count).

![](../../images/RedmineFiles/files@2x.png)

New files are added via the **New file** link in the upper right hand corner.

## File storage

All uploaded files are stored in `YYYY/MM` subdirectories (the year and month of the upload) of the `/{install dir}/files` directory, or of the directory set by `attachments_storage_path` in `config/configuration.yml`.

The stored file name is prefixed with a timestamp of the upload (`yymmddHHMMSS_`); a file name that contains characters other than ASCII letters, digits, `_`, `.` and `-`, or is longer than 50 characters, is replaced by a hash (keeping the extension when it is short).

## New file form

If a new file is added, the input form is as shown below. Select a version from the list to link a file to a specific version. Multiple files can be added at once by selecting them together in the file dialog or by dragging and dropping them onto the form.

The optional description is shown as a tooltip on the file name in the files list.

![](../../images/RedmineFiles/UploadFile.png)
