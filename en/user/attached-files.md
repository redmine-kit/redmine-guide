---
source: RedmineAttachedFiles
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineAttachedFiles
source_version: 7
source_updated_on: '2013-11-17T06:33:25Z'
---

# Redmine Attached Files

## Introduction

Attached files can be added to different resources within the Redmine system:

- issues - using the ["New File" form](attached-files.md#Attach-files-form) while adding/editing an issue
- documents - using the ["New File" form](attached-files.md#Attach-files-form) while adding/editing a document
- forum messages - using the ["New File" form](attached-files.md#Attach-files-form) while adding/editing a forum message
- news items - using the ["New File" form](attached-files.md#Attach-files-form) while adding/editing a news item
- wiki pages - using the ["New File" link](attached-files.md#Files-added-via-New-File) at the bottom of the page

## Usage

### Inline Images

Attached files can be shown within the parent page by targeting it’s name via image url (i.e. `!attached_image!`).

### Non plain text files

Keep in mind there is a dedicated [documents](documents.md) module for storing technical and user documentation that can be linked via the [wiki](wikis.md) and a dedicated [files](files.md) module for publishing versions of the tracked project, as a bundle (release).

However, if that doesn’t fit the bill, file upload support provides a way to distribute any file for user download.

## File storage

Uploaded attached files are stored in `<Redmine install dir>/files` directory subdirectories named after the year the file has been uploaded.

The uploaded file name is prefixed with a unique id based on it’s parent for directory storage. Multiple files can be uploaded with the same name, however a link within the wiki will only show the most recently uploaded one.

#### Unattached uploaded files

Uploaded files can be left unattached if the user don’t submit the form; a [Rake task](../admin/rake.md#rake-redmineattachementsprune) is made available and can be scheduled for regular deletion of these files.

## Attach files form

The input form is as shown below.

Starting from version version:2.3.0 and depending on the browser supporting it (IE10+), it is possible to:

- select and attach multiple files at once
- drag and drop files over the form

The optional description field, which appears once the file upload is finished, is also used as the alternate text of the image file inserted using `!image_url!` syntax within the parent content (i.e. issue description or note, forum message, wiki page, document, …).

![](../../images/RedmineAttachedFiles/UploadFile.png)

## Files added via “New File”

At the bottom of many of the pages in Redmine is a “New File” link. Attaching a file makes that page the parent of the file and it is limited in scope to that page.

See the [Usage](files.md#Usage) section for more information.
