---
source: RedmineLDAP
translated_from_version: 29
---

# LDAP認証

Redmine は、1 つまたは複数の LDAP ディレクトリを使った LDAP 認証に標準で対応しています。

## LDAP の登録

「管理」を開き、メニューの「LDAP認証」をクリックします。

次の項目を入力します。

- 「名称」: ディレクトリの任意の名前
- 「ホスト」: LDAP のホスト名
- 「ポート」: LDAP のポート(デフォルトは 389)
- 「LDAPS」: ディレクトリへのアクセスに LDAPS を使うとき、または使う必要があるときにチェックを入れます
- 「アカウント」: LDAP の読み取りのアクセス権があるユーザー名を入力します。LDAP を匿名で読み取れるときは空のままにします(Active Directory のサーバーは、通常は匿名のアクセスを許可しません)
- 「パスワード」: アカウントのパスワード
- 「ベースDN」: LDAP のディレクトリツリーの最上位の DN
- 「ログインIDの属性」: Redmine のユーザー名として使う LDAP の属性の名前を入力します

これで、認証に LDAP を使うように設定されたアカウントの Redmine のユーザーは、LDAP のユーザー名とパスワードで認証できます。

試すには、LDAP のアカウントと同じログイン ID で Redmine のユーザーを作成し(通常は、Redmine が LDAP のデータを参照して候補を示します)、「認証方式」のドロップダウンリストで作成した LDAP を選択し(この欄は、LDAP を登録しているときだけアカウントの画面に表示されます)、パスワードは空のままにします。LDAP のユーザー名とパスワードで Redmine にログインしてみます。

## ユーザーの自動作成

「ユーザーが存在しなければ作成」にチェックを入れると、LDAP のユーザーが初めて Redmine にログインしたときに、そのユーザーの Redmine のアカウントが自動で作成されます。\
そのためには、Redmine のアカウントの作成に使う LDAP の属性の名前(名、姓、メールアドレス)を指定する必要があります。

Active Directory を使う典型的な例です。

    Name     = My Directory
    Host     = host.domain.org
    Port     = 389
    LDAPS    = no
    Account  = MyDomain\UserName (or UserName@MyDomain depending on AD server)
    Password = <password>
    Base DN  = CN=users,DC=host,DC=domain,DC=org

    On-the-fly user creation = yes
    Attributes
      Login     = sAMAccountName
      Firstname = givenName
      Lastname  = sN
      Email     = mail

区分されたイントラネットの Active Directory の、別の例です。

    Name     = Just a description for the auth modes page
    Host     = DepartmentName.OrganizationName.local
    Port     = 389
    LDAPS    = no
    Account  = DepartmentName\UserName (or UserName@MyDomain depending on AD server or bind DN uid=Manager,cn=users,dc=MyDomain,dc=com)
    Password = <password>
    Base DN  = DC=DepartmentName,DC=OrganizationName,DC=local

    On-the-fly user creation = yes
    Attributes
      Login     = sAMAccountName
      Firstname = givenName
      Lastname  = sN
      Email     = mail

LDAP の属性の名前は、**大文字と小文字を区別**します。

### 動的なバインドのアカウント

上の設定では、Redmine が事前の認証に使う専用のアカウントが、ディレクトリサーバーに必要です。アカウントの欄でキーワード **\$login** を使うと、ログインしようとしているユーザーのログイン ID に置き換えられます。この場合、パスワードは空のままにできます。例:

    Account: $login@COMPANY.DOMAIN.NAME

または

    Account: company\$login

### ベースDN の別の例

上のベースDN は Active Directory では標準的なものと思われますが、筆者の勤務先の Active Directory では、通常のユーザーに Users コンテナーを使っていなかったため、上の手順では長く苦労しました。そこの設定でログインに失敗するときは、「DC=host,DC=domain,DC=org」だけも試すことをおすすめします。

### フィルタの別の例

グループのメンバーシップに基づくフィルタの例です。グループ `Redmine-User` のメンバーで、グループは OU `Security Groups`、`Application Settings` にあります。\
グループを作成した場所がこれで正しいか、また順序が逆になっているかを確認してください。

    Base DN: OU=Users,DC=domain,DC=lan
    LDAP Filter: (&(objectClass=user)(memberOf=CN=Redmine-User,OU=Application Settings,OU=Security Groups,DC=domain,DC=lan))

## グループに基づく LDAP のログイン

特定の LDAP のグループに所属するユーザーだけにログインを許可するときは、次の手順に従います。手順は、OpenLDAP の LDAP サーバーと Redmine 2.3.0 に基づいています。

1\. (OpenLDAP のサーバー)memberof のオーバーレイを有効にします

1.1. 次のファイルを作成します。

\>vim ~/memberof_add.ldif

内容は次のとおりです。

\>dn: cn=module,cn=config\
\>objectClass: olcModuleList\
\>cn: module\
\>olcModulePath: /usr/lib/ldap\
\>olcModuleLoad: memberof

1.2. 次のファイルを作成します。

\>vim ~/memberof_config.ldif

内容は次のとおりです。

\>dn: olcOverlay=memberof,olcDatabase={1}hdb,cn=config\
\>objectClass: olcMemberOf\
\>objectClass: olcOverlayConfig\
\>objectClass: olcConfig\
\>objectClass: top\
\>olcOverlay: memberof\
\>olcMemberOfDangling: ignore\
\>olcMemberOfRefInt: TRUE\
\>olcMemberOfGroupOC: groupOfNames\
\>olcMemberOfMemberAD: member\
\>olcMemberOfMemberOfAD: memberOf

1.3. これらを読み込みます。方法は OpenLDAP の設定によって異なるため、いくつかの方法を示します。

\>sudo ldapadd -c -Y EXTERNAL -H ldapi:/// -f memberof_add.ldif\
\>sudo ldapadd -c -Y EXTERNAL -H ldapi:/// -f memberof_config.ldif

または

\>ldapadd -D cn=admin,cn=config -w “password” -H ldapi:/// -f memberof_add.ldif\
\>ldapadd -D cn=admin,cn=config -w “password” -H ldapi:/// -f memberof_config.ldif

実行時に動的に設定するエンジン(slapd-config)を使っているときは、再起動は必要ありません。

1.4. (任意)テストします。

\>ldapsearch -D cn=admin,dc=example,dc=com -x -W -b ‘dc=example,dc=com’ -H ‘ldap://127.0.0.1:389/’ ‘(&(objectClass=posixAccount)(memberOf=cn=ldapredmine,ou=groups,dc=example,dc=com))’

2\. (OpenLDAP のサーバー)グループを作成します。この例では、ユーザーは「ldap_user_1」、グループは「ldapredmine」です。

\>dn: cn=ldapredmine,ou=groups,dc=example,dc=com\
\>cn: ldapredmine\
\>description: Staff members allowed to login to redmine ticketing system\
\>member: cn=ldap_user_1,ou=people,dc=example,dc=com\
\>objectclass: groupOfNames\
\>objectclass: top

「dn」と「cn」は、DIT の構造に合わせて調整してください。

3\. (Redmine)LDAP の認証方式を編集します。この例では、「ldap_user_1」は objectclass が「posixAccount」です。

\>Base DN: dc=example,dc=com\
\>Filter: (&(objectClass=posixAccount)(memberOf=cn=ldapredmine,ou=groups,dc=example,dc=com))

## トラブルシューティング

ユーザーの自動作成を使うときは、正しいユーザーを作成するのに必要な情報を、Redmine が LDAP からすべて取得できることを確認してください。\
たとえば、ディレクトリに正しいメールアドレスがないと、ユーザーの自動作成は動きません(ログインしようとすると「Invalid username/password」のエラーメッセージが表示されます)。\
(新しいバージョンの Redmine では当てはまりません。ユーザーの作成のダイアログに LDAP サーバーから見つかった情報がすべて入力され、残りは新しいユーザーが入力するように求められます。)

また、ユーザーアカウントのカスタムフィールドで「必須」にしているものがないことを確認してください。必須のカスタムフィールドがあると、ユーザーアカウントを自動で作成できません。

ログインの仕組みのエラーは、Redmine のログに役立つ情報が記録されないため、トラブルシューティングは難しくなります。ただし、Redmine のホストと LDAP サーバーの間で Wireshark を使うと、必要な情報はほとんど得られます。これは、この 2 つのホストの間のネットワークの通信を読み取る権限があるときだけ使えます。

ツール「ldapsearch」で、設定が正しいかどうかを確認することもできます。Redmine を動かしている Linux のマシンにログインし(必要なら ldaputils をインストールし)、次を実行します。

ldapsearch -x -b “dc=example,dc=com” -H ldap://hostname/ -D “DOMAIN\USER” -w mypassword \[searchterm\]

成功すると、AD の内容のうち検索の条件に一致するものが一覧で表示されます。これで、Redmine の LDAP の設定の各欄に何を入力すればよいかがわかります。

### アカウントの値の形式

source:trunk/vendor/plugins/ruby-net-ldap-0.0.4/lib/net/ldap.rb の次のコメントのとおり、バインドの資格情報のユーザー名は、UPN(user@domain.com)や domain\user ではなく、DN(CN=user,OU=optional,DC=domain,DC=com など)で指定する必要がある場合があります。

      # As described under #bind, most LDAP servers require that you supply a complete DN
      # as a binding-credential, along with an authenticator such as a password.

\
そのため、ユーザー名が MyDomain\MyUserName や MyUserName@MyDomain.com のユーザーは、Redmine のログイン ID として MyUserName だけを入力すればよい場合があります。

### LDAP の認証が遅い

LDAP の認証が遅く、AD のクラスターを使っているときは、「ホスト」の欄に AD の物理サーバーの 1 つを指定してみてください(http://www.redmine.org/boards/2/topics/3056)。改善することがあります。

### OpenDS

OpenDS のサーバーを使っているときは、指定したログイン ID の属性でユーザーを検索する最初の問い合わせに付く、要求コントロール「Paged results」で問題が起きることがあります。この要求コントロール 1.2.840.113556.1.4.319 は、デフォルトでは匿名ユーザーに許可されていません。そのため、バインドの前の段階で、Redmine がディレクトリからユーザーを見つけられません。

次のような、全体の ACI を追加します。

    ./dsconfig -h SERVER_IP -p 4444 -D cn="Directory Manager" -w PASSWORD -n set-access-control-handler-prop --trustAll 
    --add global-aci:\(targetcontrol=\"1.2.840.113556.1.4.319\"\)\ \(version\ 3.0\;\ acl\ 
    \"Anonymous\ control\ access\ to\ 1.2.840.113556.1.4.319\"\;\ allow\ \(read\)\ userdn=\"ldap:///anyone\"\;\)

注: コマンドは 1 行で入力し、エスケープは示したとおりに正確に使ってください(「acl」の後の \\ は、空白を表す「\\ 」のつもりです)。

## 解決例:

### Zentyal 3.2、Redmine 2.3.x

Ubuntu 12.04 LTS のサーバーで、Zentyal 3.2 の更新と(再)設定に成功しました。

Zentyal 3.2 と Redmine 2.3 に更新した後、これにはとても悩まされたので、手短に、この簡単な解決方法を共有します。

- https://wiki.blue-it.org/Zentyal#LDAP

Zentyal の読み取り専用の資格情報を使います。

    > Basedomain (Base DN):  dc=your_domain,dc=your_tld
      Rootdomain (Root DN):  cn=zentyal,dc=your_domain,dc=your_tld
      Password:              <admin_secret_pass>
    > Read-only root DN:     cn=zentyalro,dc=your_domain,dc=your_tld
    > Read-only password:    <ro_secret_pass>
      Default Users DN:      ou=Users,dc=your_domain,dc=your_tld
      Default Groups DN:     ou=Groups,dc=your_domain,dc=your_tld

Redmine では、上の資格情報を(\<\> を除いて)使います。LDAP のポートが 390 に変わっていることに注意してください(上の記事を参照)。

    Name     = Just a description for the auth modes page
    > Host     = <IP of the host>
    > Port     = <390>
      LDAPS    = no
    > Account  = <Read-only root DN>
    > Password = <ro_secret_pass>
    > Base DN  = <Basedomain (Base DN)>

    On-the-fly user creation = yes
    Attributes
    >  Login     = uid
       Firstname = givenName
    >  Lastname  = sN
      Email     = mail

### Zentyal 4.x、Redmine 3.3.x

ポート 389 を使い、uid の代わりに sAMAccountName を使います。

### Zentyal 5.0、Redmine 3.2

      Name     = Just a description for the auth modes page
      Host     = <IP of the host>
      Port     = <389>
      LDAPS    = no (yes/checked is ok too with Port set to 636)
      Account  = username@domain.tld
      Password = <username_pass>
      Base DN  = < Default Users DN > (cn=Users,dc=domain,dc=tld)   

    On-the-fly user creation = yes
    Attributes
       Login     = sAMAccountName
       Firstname = givenName
       Lastname  = sN
       Email     = mail

### OpenLDAP、Redmine 3.4.2.stable

      Name     = Some random description
      Host     = <IP of the host>
      Port     = <389>
      LDAPS    = no
      Account  = < Admins DN > (cn=admin,dc=domain,dc=tld)
      Password = < Admins Pass >
      Base DN  = < Default Users DN > (cn=People,dc=domain,dc=tld)   

    On-the-fly user creation = yes
    Attributes
       Login     = uid
       Firstname = givenName
       Lastname  = sn
       Email     = mail

admin のアカウントは、全体の読み取りの権限がある別の LDAP のアカウントでもかまいません。「domain」と「tld」の部分は、ほかの部分と同じく LDAP の設定に合わせる必要があります。ログインにはログイン ID の属性を使います。残りは LDAP の設定に合わせます。

### FreeIPA 4.6.8、Redmine 3.2.6

      Name     = Service Description or server name etc.
      Host     = <IP/domain of the host>
      Port     = <389>
      LDAPS    = no ("yes" not tested)
      Account  = uid=<bind username>,cn=users,cn=accounts,dc=<domain>,dc=<tld>
      Password = <bind password>
      Base DN   = cn=accounts,dc=<domain>,dc=<tld>

    Attributes
       Login     = uid
       Firstname = givenName
       Lastname  = sn
       Email     = mail

「domain」と「tld」の部分は、ほかの部分と同じく LDAP の設定に合わせる必要があります。ログインには uid の属性を使います。
