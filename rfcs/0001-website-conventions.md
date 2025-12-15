# RFC-0001 S4C: Website Conventions

## 1. Introduction

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to
be interpreted as described in [RFC 2119](www.ietf.org).

With the growing number of projects hosted within the open-s4c organization,
the wish of exposing them in an organized way via a single webpage has
arisen. This document defines the conventions for project documentation to
be displayed on the open-s4c website.

## 2. The open-s4c website

The open-s4c website is located at https://open-s4c.github.io.

It is hosted on GitHub and uses GitHub's Jekyll automatic
build. The source of the website is located in this git repository:
https://github.com/open-s4c/open-s4c.github.io.

Henceforth, we refer to this repository as **SITE** and **SITE/FOLDER**
refers to folders relative to the root of SITE.

- 2.1. Only website maintainers or automated tools **SHALL** push to SITE.
- 2.2. Changes **MAY** be pushed directly to the SITE main branch without
  the need for a pull request or approvals.
- 2.3. Forced pushes **SHOULD NOT** be performed without a previous discussion
  with all maintainers.

The root of SITE contains the main `README.md` file, as well as assets and
Jekyll configuration files.

- 2.4. Changes in the SITE root, including website style changes, **REQUIRE**
  discussion with all maintainers.

## 3. Project folders in SITE

Projects hosted in open-s4c can expose their documentation, including figures
and other files, within the SITE repository.

- 3.1. Project folders **SHALL** match the project name and be placed in the
  root of SITE (e.g., `SITE/libvsync` is the folder for the `libvsync` project).
- 3.2. Projects **SHALL** use Markdown for all documentation within SITE.

The entry point of `SITE/FOLDER` is a `README.md` file, henceforth called
the project's **INDEX** file.

- 3.3. The **INDEX** file of each project **SHALL** at least contain:
    *   The Project name
    *   A description of the project
    *   A link to the project repository
- 3.4. The contents of `SITE/FOLDER` **MAY** include any additional information
  related to the project, and **MAY** use subfolders.

## 4. The 'doc' convention

Projects are encouraged to use the **doc convention** defined in this
section, which may be extended in the future. Adherence to this convention
is optional. The requirements for this convention are as follows:

- 4.1. A project **SHOULD** contain a `doc/` folder in its main repository
  with a `README.md` file and arbitrary content.
- 4.2. File links within the `doc/` folder **MUST** be relative and
  **MUST NOT** escape to the parent folder (e.g., no `../`).

With these requirements, the content of the `doc/` folder **SHALL** be copied
verbatim into `SITE/PROJECT`. This process **SHALL** happen automatically
via script. The file `doc/README.md` becomes the project **INDEX** file.

## 5. The 'doc/api' convention

A further convention is the **doc/api convention**. Its requirements are
as follows:

- 5.1. The project **MUST** adhere to the base doc convention (rules 4.x).
- 5.2. The latest project API documentation **MUST** be kept inside the
  `doc/api` subfolder.
- 5.3. The format of the API documentation **MUST** be Markdown.
- 5.4. The project **MUST** be versioned (i.e., it must have releases).
- 5.5. The project's **INDEX** file **MUST** have one or more links pointing
  to content within `api/...`.
- 5.6. Other Markdown files in `doc/` **MAY** have one or more links to
  content within `api/...`.

With these requirements, on every new release, the content of `doc/api` is
copied into `SITE/FOLDER/api/VERSION`, where `VERSION` is the version string
of the new release. This process **SHALL** happen automatically via script.

All Markdown files in `SITE/FOLDER/...` (excluding those already within the
`api` subfolders) **SHALL** have any link prefixed with `api/` automatically
rewritten with the prefix `api/VERSION/`. This process **SHALL** happen
automatically via script.

