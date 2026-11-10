---
source: Rest_api_with_php
translated_from_version: 14
---

# PHP で REST API を使う

## php-redmine-api プロジェクト

- シンプルなオブジェクト指向の PHP の Redmine API クライアント:
  - https://github.com/kbsali/php-redmine-api

## PHP ActiveResource を使う方法

Rails の REST API にアクセスできる軽量な PHP のライブラリ、[PHP ActiveResource](http://wiki.github.com/lux/phpactiveresource/) を使う例です。

```php
<?php
require_once ('ActiveResource.php');

class Issue extends ActiveResource {
    var $site = 'http://username:password@192.168.199.129:3000/';
    var $request_format = 'xml'; // REQUIRED!
}

// create a new issue
$issue = new Issue (array ('subject' => 'XML REST API', 'project_id' => '1'));
$issue->save ();
echo $issue->id;

// find issues
$issues = $issue->find ('all');
for ($i=0; $i < count($issues); $i++) {
    echo $issues[$i]->subject;
}

// find and update an issue
$issue->find (1);
echo $issue->subject;
$issue->set ('subject', 'This is the new subject')->save ();
// update status
$issue->set ('status_id', 2)->save();

// delete an issue
$issue->find (1);
$issue->destroy ();
?>
```

**既知の問題**

- 大きな説明を扱うと、Web サーバーが 417 のエラー (Bad Expectation) を返すことがあります。\
  *ActiveResource.php* の 381 行目を次のコードに置き換えてください。

```php
curl_setopt ($ch, CURLOPT_HTTPHEADER, array ('Expect:',"Content-Type: text/xml", "Length: " . strlen ($params)));
```

- このクラスで `time_entries` を書き込もうとすると、404 のレスポンスが返ります (#9375)。このクラスが、エンティティの名前の複数形から正しい単数形を作れないためです (2011-10-06 追記: Web サイトによると、この不具合は最新のリリースで修正されています: https://github.com/lux/phpactiveresource/issues/7#issuecomment-2300502)。\
  *ActiveResource.php* を次のように修正すると直せます。

1.  クラス変数 `$sOriginalElementName` を追加します。

    ```php
    protected $sOriginalElementName = '';
    ```

2.  複数形にする前に、元のエンティティの名前でクラス変数を設定するように、コンストラクターを変更します。

    ```php
    function __construct ($data = array ()) {
      $this->_data = $data;

      // add this line here - to store the original name of the entity
      $this->sOriginalElementName = ($this->element_name ? $this->element_name : strtolower (get_class ($this)));
      // Allow class-defined element name or use class name if not defined
      $this->element_name = ($this->element_name ? $this->pleuralize ($this->element_name) : $this->pleuralize (strtolower (get_class ($this))));
    ...
    ```

3.  続けて、`substr ($this->element_name, 0, -1)` の代わりに `$sOriginalElementName` を使うように、メソッド `_send_and_receive` を変更します。

    ```php
    function _send_and_receive ($url, $method, $data = array ()) {
      $params = '';
      $el = $this->sOriginalElementName;//substr ($this->element_name, 0, -1);
      if ($this->request_format == 'url') {
    ...
    ```
