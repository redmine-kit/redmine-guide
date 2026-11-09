---
source: RedmineCodeHighlightingLanguages
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineCodeHighlightingLanguages
source_version: 11
source_updated_on: '2024-11-14T10:41:16Z'
---

# Code highlighting supported languages

Default code highlighting relies on [Rouge](http://rouge.jneen.net/) since Redmine 4.0.0. It supports over 200 languages. Refer [RedmineTextFormattingTextile#Code-highlighting](text-formatting-textile.md#Code-highlighting) or [RedmineTextFormattingMarkdown#Code-highlighting](text-formatting-markdown.md#Code-highlighting) for how to highlight code.

Here is a list of supported languages by Rouge 4.5.0, which is bundled with Redmine 6.0.1. You can also get a list by running `bundle exec rougify list` in the installation directory of Redmine.

| Language | Description |
|----|----|
| `abap` | SAP - Advanced Business Application Programming |
| `actionscript` | ActionScript \[aliases: as,as3\] |
| `ada` | The Ada 2012 programming language |
| `apache` | configuration files for Apache web server |
| `apex` | The Apex programming language (provided by salesforce) |
| `apiblueprint` | Markdown based API description language. \[aliases: apiblueprint,apib\] |
| `applescript` | The AppleScript scripting language by Apple Inc. (https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html) \[aliases: applescript\] |
| `armasm` | Arm assembly syntax |
| `augeas` | The Augeas programming language (augeas.net) \[aliases: aug\] |
| `awk` | pattern-directed scanning and processing language |
| `batchfile` | Windows Batch File \[aliases: bat,batch,dosbatch,winbatch\] |
| `bbcbasic` | BBC BASIC syntax |
| `bibtex` | BibTeX \[aliases: bib\] |
| `biml` | BIML, Business Intelligence Markup Language |
| `bpf` | BPF bytecode syntax |
| `brainfuck` | The Brainfuck programming language \[aliases: bf\] |
| `brightscript` | BrightScript Programming Language (https://developer.roku.com/en-ca/docs/references/brightscript/language/brightscript-language-reference.md) \[aliases: bs,brs\] |
| `bsl` | The 1C:Enterprise programming language |
| `c` | The C programming language |
| `ceylon` | Say more, more clearly. |
| `cfscript` | CFScript, the CFML scripting language \[aliases: cfc\] |
| `cisco_ios` | Cisco IOS configuration lexer |
| `clean` | The Clean programming language (clean.cs.ru.nl) |
| `clojure` | The Clojure programming language (clojure.org) \[aliases: clj,cljs\] |
| `cmake` | The cross-platform, open-source build system |
| `cmhg` | RISC OS C module header generator source file |
| `cobol` | COBOL (Common Business-Oriented Language) programming language |
| `codeowners` | Code Owners syntax (https://docs.gitlab.com/ee/user/project/codeowners/reference.html) |
| `coffeescript` | The Coffeescript programming language (coffeescript.org) \[aliases: coffee,coffee-script\] |
| `common_lisp` | The Common Lisp variant of Lisp (common-lisp.net) \[aliases: cl,common-lisp,elisp,emacs-lisp,lisp\] |
| `conf` | A generic lexer for configuration files \[aliases: config,configuration\] |
| `console` | A generic lexer for shell sessions. Accepts ?lang and ?output lexer options, a ?prompt option, ?comments to enable \# comments, and ?error to handle error messages. \[aliases: terminal,shell_session,shell-session,terminal,shell_session,shell-session\] |
| `coq` | Coq (coq.inria.fr) |
| `cpp` | The C++ programming language \[aliases: c++,c++\] |
| `crystal` | Crystal The Programming Language (crystal-lang.org) \[aliases: cr\] |
| `csharp` | a multi-paradigm language targeting .NET \[aliases: c#,cs\] |
| `css` | Cascading Style Sheets, used to style web pages |
| `csvs` | The CSV Schema Language (digital-preservation.github.io) |
| `cuda` | Compute Unified Device Architecture, used for programming with NVIDIA GPU |
| `cypher` | The Cypher query language (neo4j.com/docs/cypher-manual) \[aliases: cypher\] |
| `cython` | Cython and Pyrex source code (cython.org) \[aliases: pyx,pyrex\] |
| `d` | The D programming language(dlang.org) \[aliases: dlang\] |
| `dafny` | The Dafny programming language (github.com/dafny-lang/dafny) |
| `dart` | The Dart programming language (dart.dev) |
| `datastudio` | Datastudio scripting language |
| `diff` | Lexes unified diffs or patches \[aliases: patch,udiff\] |
| `digdag` | A simple, open source, multi-cloud workflow engine (https://www.digdag.io/) |
| `docker` | Dockerfile syntax \[aliases: dockerfile,Dockerfile,containerfile,Containerfile\] |
| `dot` | graph description language \[aliases: graphviz\] |
| `ecl` | Enterprise Control Language (hpccsystems.com) |
| `eex` | Embedded Elixir \[aliases: leex,heex\] |
| `eiffel` | Eiffel programming language |
| `elixir` | Elixir language (elixir-lang.org) \[aliases: elixir,exs\] |
| `elm` | The Elm programming language (http://elm-lang.org/) |
| `email` | An email message \[aliases: eml,e-mail\] |
| `epp` | Embedded Puppet template files |
| `erb` | Embedded ruby template files \[aliases: eruby,rhtml\] |
| `erlang` | The Erlang programming language (erlang.org) \[aliases: erl\] |
| `escape` | A generic lexer for including escaped content - see Formatter.enable_escape! \[aliases: esc\] |
| `factor` | Factor, the practical stack language (factorcode.org) |
| `fluent` | Fluent localization files \[aliases: ftl\] |
| `fortran` | Fortran 2008 (free-form) |
| `freefem` | The FreeFEM programming language (freefem.org) \[aliases: ff\] |
| `fsharp` | F# (fsharp.net) |
| `gdscript` | The Godot Engine programming language (https://godotengine.org/) \[aliases: gd,gdscript\] |
| `ghc-cmm` | GHC Cmm is the intermediate representation of the GHC Haskell compiler \[aliases: cmm\] |
| `ghc-core` | Intermediate representation of the GHC Haskell compiler. |
| `gherkin` | A business-readable spec DSL (github.com/cucumber/cucumber/wiki/Gherkin) \[aliases: cucumber,behat\] |
| `glsl` | The GLSL shader language |
| `go` | The Go programming language (http://golang.org) \[aliases: go,golang\] |
| `gradle` | A powerful build system for the JVM |
| `graphql` | GraphQL |
| `groovy` | The Groovy programming language (http://www.groovy-lang.org/) \[aliases: nextflow,nf,nextflow,nf\] |
| `hack` | The Hack programming language (hacklang.org) \[aliases: hack,hh\] |
| `haml` | The Haml templating system for Ruby (haml.info) \[aliases: HAML\] |
| `handlebars` | the Handlebars and Mustache templating languages \[aliases: hbs,mustache\] |
| `haskell` | The Haskell programming language (haskell.org) \[aliases: hs\] |
| `haxe` | Haxe Cross-platform Toolkit (http://haxe.org) \[aliases: hx,haxe\] |
| `hcl` | Hashicorp Configuration Language, used by Terraform and other Hashicorp tools |
| `hlsl` | HLSL, the High Level Shading Language for DirectX (docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl) |
| `hocon` | Human-Optimized Config Object Notation (https://github.com/lightbend/config) |
| `hql` | Hive Query Language SQL dialect |
| `html` | HTML, the markup language of the web |
| `http` | http requests and responses |
| `hylang` | The HyLang programming language (hylang.org) \[aliases: hy\] |
| `idlang` | Interactive Data Language |
| `idris` | The Idris programming language (idris-lang.org) \[aliases: idr\] |
| `iecst` | Structured text is a programming language for PLCs (programmable logic controllers). |
| `igorpro` | WaveMetrics Igor Pro |
| `ini` | the INI configuration format |
| `io` | The IO programming language (http://iolanguage.com) |
| `irb` | Shell sessions in IRB or Pry \[aliases: pry\] |
| `isabelle` | Isabelle theories (isabelle.in.tum.de) \[aliases: isa,Isabelle\] |
| `isbl` | The ISBL programming language |
| `j` | The J programming language (jsoftware.com) |
| `janet` | The Janet programming language (janet-lang.org) \[aliases: jdn\] |
| `java` | The Java programming language (java.com) |
| `javascript` | JavaScript, the browser scripting language \[aliases: js,js\] |
| `jinja` | Django/Jinja template engine (jinja.pocoo.org) \[aliases: django,django\] |
| `jsl` | The JMP Scripting Language (JSL) (jmp.com) |
| `json` | JavaScript Object Notation (json.org) |
| `json-doc` | JavaScript Object Notation with extensions for documentation \[aliases: jsonc\] |
| `json5` | JSON 5 extension for JSON (json5.org) |
| `jsonnet` | An elegant, formally-specified config language for JSON |
| `jsp` | JSP |
| `jsx` | An XML-like syntax extension to JavaScript (facebook.github.io/jsx/) \[aliases: jsx,react,jsx,react\] |
| `julia` | The Julia programming language \[aliases: jl\] |
| `kotlin` | Kotlin Programming Language (http://kotlinlang.org) |
| `lasso` | The Lasso programming language (lassosoft.com) \[aliases: lassoscript\] |
| `lean` | The Lean programming language (leanprover.github.io) \[aliases: lean\] |
| `liquid` | Liquid is a templating engine for Ruby (liquidmarkup.org) |
| `literate_coffeescript` | Literate coffeescript \[aliases: litcoffee\] |
| `literate_haskell` | Literate haskell \[aliases: lithaskell,lhaskell,lhs\] |
| `livescript` | LiveScript, a language which compiles to JavaScript (livescript.net) \[aliases: ls\] |
| `llvm` | The LLVM Compiler Infrastructure (http://llvm.org/) |
| `lua` | Lua (http://www.lua.org) |
| `lustre` | The Lustre programming language (Verimag) |
| `lutin` | The Lutin programming language (Verimag) |
| `m68k` | Motorola 68k Assembler |
| `magik` | Smallworld Magik |
| `make` | Makefile syntax \[aliases: makefile,mf,gnumake,bsdmake\] |
| `markdown` | Markdown, a light-weight markup language for authors \[aliases: md,mkd,md,mkd\] |
| `mason` | The HTML::Mason framework (https://metacpan.org/pod/HTML::Mason) |
| `mathematica` | Wolfram Mathematica, the world’s definitive system for modern technical computing. \[aliases: wl,wolfram\] |
| `matlab` | Matlab \[aliases: m\] |
| `meson` | Meson’s specification language (mesonbuild.com) |
| `minizinc` | MiniZinc is a free and open-source constraint modeling language (minizinc.org) |
| `mojo` | The Mojo programming language (modular.com) \[aliases: mojo\] |
| `moonscript` | Moonscript (http://www.moonscript.org) \[aliases: moon\] |
| `mosel` | An optimization language used by Fico’s Xpress. |
| `msgtrans` | RISC OS message translator messages file |
| `mxml` | MXML |
| `nasm` | Netwide Assembler |
| `nesasm` | Nesasm3 assembly (6502 asm) \[aliases: nes\] |
| `nginx` | configuration files for the nginx web server (nginx.org) |
| `nial` | The Nial programming language (nial-array-language.org) |
| `nim` | The Nim programming language (http://nim-lang.org/) \[aliases: nimrod\] |
| `nix` | The Nix expression language (https://nixos.org/nix/manual/#ch-expression-language) \[aliases: nixos\] |
| `objective_c` | an extension of C commonly used to write Apple software \[aliases: objc,obj-c,obj_c,objectivec,objective-c\] |
| `objective_cpp` | an extension of C++ uncommonly used to write Apple software \[aliases: objcpp,obj-cpp,obj_cpp,objectivecpp,objc++,obj-c++,obj_c++,objectivec++\] |
| `ocaml` | Objective Caml (ocaml.org) |
| `ocl` | OMG Object Constraint Language (omg.org/spec/OCL) \[aliases: OCL\] |
| `openedge` | The OpenEdge ABL programming language \[aliases: abl\] |
| `opentype_feature_file` | Feature specifications for an OpenType font (adobe-type-tools.github.io/afdko) \[aliases: fea,opentype,opentypefeature\] |
| `p4` | The P4 programming language |
| `pascal` | a procedural programming language commonly used as a teaching language. |
| `perl` | The Perl scripting language (perl.org) \[aliases: pl\] |
| `php` | The PHP scripting language (php.net) \[aliases: php,php3,php4,php5,php,php3,php4,php5\] |
| `plaintext` | A boring lexer that doesn’t highlight anything \[aliases: text\] |
| `plist` | plist \[aliases: plist\] |
| `plsql` | Procedural Language Structured Query Language for Oracle relational database |
| `postscript` | The PostScript language (adobe.com/devnet/postscript.html) \[aliases: postscr,postscript,ps,eps\] |
| `powershell` | powershell \[aliases: posh,microsoftshell,msshell\] |
| `praat` | The Praat scripting language (praat.org) |
| `prolog` | The Prolog programming language (http://en.wikipedia.org/wiki/Prolog) \[aliases: prolog\] |
| `prometheus` | prometheus \[aliases: prometheus\] |
| `properties` | .properties config files for Java |
| `protobuf` | Google’s language-neutral, platform-neutral, extensible mechanism for serializing structured data \[aliases: proto\] |
| `puppet` | The Puppet configuration management language (puppetlabs.org) \[aliases: pp\] |
| `python` | The Python programming language (python.org) \[aliases: py,py\] |
| `q` | The Q programming language (kx.com) \[aliases: kdb+\] |
| `qml` | QML, a UI markup language \[aliases: qml\] |
| `r` | The R statistics language (r-project.org) \[aliases: r,R,s,S\] |
| `racket` | Racket is a Lisp descended from Scheme (racket-lang.org) |
| `reasonml` | New syntax on top of OCaml ecosystem (reasonml.github.io) |
| `rego` | The Rego open-policy-agent (OPA) policy language (openpolicyagent.org) |
| `rescript` | The ReScript programming language (rescript-lang.org) |
| `rml` | A system agnostic domain-specific language for runtime monitoring and verification (https://rmlatdibris.github.io/) |
| `robot_framework` | Robot Framework is a generic open source automation testing framework (robotframework.org) \[aliases: robot,robot-framework\] |
| `ruby` | The Ruby programming language (ruby-lang.org) \[aliases: rb,rb\] |
| `rust` | The Rust programming language (rust-lang.org) \[aliases: rs,rust,no_run,rs,no_run,rust,ignore,rs,ignore,rust,should_panic,rs,should_panic\] |
| `sas` | SAS (Statistical Analysis Software) |
| `sass` | The Sass stylesheet language language (sass-lang.com) |
| `scala` | The Scala programming language (scala-lang.org) \[aliases: scala\] |
| `scheme` | The Scheme variant of Lisp |
| `scss` | SCSS stylesheets (sass-lang.com) |
| `sed` | sed, the ultimate stream editor |
| `shell` | Various shell languages, including sh and bash \[aliases: bash,zsh,ksh,sh\] |
| `sieve` | mail filtering language |
| `slice` | Specification Language for Ice (doc.zeroc.com) |
| `slim` | The Slim template language |
| `smalltalk` | The Smalltalk programming language \[aliases: st,squeak\] |
| `smarty` | Smarty Template Engine \[aliases: smarty\] |
| `sml` | Standard ML \[aliases: ml\] |
| `sparql` | Semantic Query Language, for RDF data |
| `sqf` | Status Quo Function, a Real Virtuality engine scripting language |
| `sql` | Structured Query Language, for relational databases |
| `ssh` | A lexer for SSH configuration files |
| `stan` | Stan Modeling Language (mc-stan.org) |
| `stata` | The Stata programming language (www.stata.com) |
| `supercollider` | A cross-platform interpreted programming language for sound synthesis, algorithmic composition, and realtime performance |
| `svelte` | Svelte single-file components (https://svelte.dev/) |
| `swift` | Multi paradigm, compiled programming language developed by Apple for iOS and OS X development. (developer.apple.com/swift) |
| `systemd` | A lexer for systemd unit files \[aliases: unit-file\] |
| `syzlang` | Syscall description language used by syzkaller |
| `syzprog` | Program description language used by syzkaller |
| `tap` | Test Anything Protocol \[aliases: tap\] |
| `tcl` | The Tool Command Language (tcl.tk) |
| `terraform` | Terraform HCL Interpolations \[aliases: tf\] |
| `tex` | The TeX typesetting system \[aliases: TeX,LaTeX,latex\] |
| `toml` | the TOML configuration format (https://github.com/toml-lang/toml) |
| `tsx` | TypeScript-compatible JSX (www.typescriptlang.org/docs/handbook/jsx.html) |
| `ttcn3` | The TTCN3 programming language (ttcn-3.org) |
| `tulip` | the tulip programming language (twitter.com/tuliplang) \[aliases: tulip\] |
| `turtle` | Terse RDF Triple Language, TriG |
| `twig` | Twig template engine (twig.sensiolabs.org) |
| `typescript` | TypeScript, a superset of JavaScript (https://www.typescriptlang.org/) \[aliases: ts\] |
| `vala` | A programming language similar to csharp. |
| `vb` | Visual Basic \[aliases: visualbasic\] |
| `vcl` | The configuration language for Varnish HTTP Cache (varnish-cache.org) \[aliases: varnishconf,varnish\] |
| `velocity` | Velocity is a Java-based template engine (velocity.apache.org) |
| `verilog` | The System Verilog hardware description language |
| `vhdl` | Very High Speed Integrated Circuit Hardware Description Language |
| `viml` | VimL, the scripting language for the Vim editor (vim.org) \[aliases: vim,vimscript,ex\] |
| `vue` | Vue.js single-file components \[aliases: vuejs\] |
| `wollok` | Wollok lang |
| `xml` | <desc for="this-lexer">XML</desc> |
| `xojo` | Xojo \[aliases: realbasic\] |
| `xpath` | XML Path Language (XPath) 3.1 |
| `xquery` | XQuery 3.1: An XML Query Language |
| `yaml` | Yaml Ain’t Markup Language (yaml.org) \[aliases: yml,yml\] |
| `yang` | Lexer for the YANG 1.1 modeling language (RFC7950) |
| `zig` | The Zig programming language (ziglang.org) \[aliases: zir\] |

{{collapse(Note for the wiki maintainers)\
The table above can be generated by running the following command.

    bundle exec rougify list | ruby -nle 'if $_ =~ /^([a-z0-9_-]+): (.+)/ ; puts "| @#{$1}@ | #{$2} |"; end'

\
}}
