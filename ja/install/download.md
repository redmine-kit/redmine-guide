---
source: Download
translated_from_version: 251
---

# ダウンロード

## 最新のリリース

Redmine のリリースは `.tar.gz` と `.zip` の形式で入手できます。

<table>
<tbody>
<tr>
<td rowspan="2">redmine-6.0.12</td>
<td rowspan="2">2026-11-01</td>
<td><a href="https://www.redmine.org/releases/redmine-6.0.12.tar.gz">redmine-6.0.12.tar.gz</a></td>
<td><code>9df2d08cff4264a2f49b380666018ac388cc17cddd75594c58cf55833f6d021b</code></td>
</tr>
<tr>
<td><a href="https://www.redmine.org/releases/redmine-6.0.12.zip">redmine-6.0.12.zip</a></td>
<td><code>383eb661a6a91f9217d319e57e8fc8c64f7cfba5adf3929c398c03cc8a0bbe66</code></td>
</tr>
<tr>
<td rowspan="2">redmine-6.1.6</td>
<td rowspan="2">2026-11-01</td>
<td><a href="https://www.redmine.org/releases/redmine-6.1.6.tar.gz">redmine-6.1.6.tar.gz</a></td>
<td><code>a09f0541e3ef5579de8be1c21fc9cabbd7625d77ec4dd2ddddc39ad9c2c5a483</code></td>
</tr>
<tr>
<td><a href="https://www.redmine.org/releases/redmine-6.1.6.zip">redmine-6.1.6.zip</a></td>
<td><code>9fb1c4caf380db9b84bd9421f0964a58ad43d218e60841b0d8e263a436ceb792</code></td>
</tr>
<tr>
<td rowspan="2">redmine-7.0.3</td>
<td rowspan="2">2026-11-01</td>
<td><a href="https://www.redmine.org/releases/redmine-7.0.3.tar.gz">redmine-7.0.3.tar.gz</a></td>
<td><code>0b6b24c033341a9d7ad52cfcfa7b1bc913c191c7a604f740d863f16249dd3c15</code></td>
</tr>
<tr>
<td><a href="https://www.redmine.org/releases/redmine-7.0.3.zip">redmine-7.0.3.zip</a></td>
<td><code>ee82a3c405aba179f1b6e27ce8a3b8ae18280778e539493e45c8de3b73229529</code></td>
</tr>
</tbody>
</table>

変更の詳細は [Changelog](https://www.redmine.org/projects/redmine/wiki/Changelog)、インストールの手順は [RedmineInstall](install.md)、バージョンアップの手順は [RedmineUpgrade](upgrade.md) を参照してください。

[以前のリリース](https://www.redmine.org/releases/)も入手できます。

## バージョンのサポート状況とリリースの方針

| バージョン | サポート状況 |
|----|----|
| trunk | 不安定なバージョンです。新機能、不具合の修正、セキュリティの更新が入ります。 |
| **7.0.x** | **最新の安定バージョンです。新機能、不具合の修正、セキュリティの更新を含め、完全にサポートします。** |
| 6.1.x | 最新の安定バージョンです。不具合の修正とセキュリティの更新だけが入ります。 |
| 6.0.x | 旧安定バージョンです。重要なセキュリティの更新だけが入ります。 |
| 5.1.x | サポート終了 |
| 5.0.x | サポート終了 |
| 4.x 以前 | サポート終了 |

### リリースの方針

- 次の Redmine のリリースは、いつでも[ロードマップ](https://www.redmine.org/projects/redmine/roadmap)のページで確認できます
- 可能な範囲で、次のようにリリースします。
  - マイナーバージョンは 3 か月ごと
  - メジャーバージョンは年に 1 回
  - 重大・重要なセキュリティの修正や大きな不具合の修正は、できるだけ早く

### サポートの方針

- 最新のマイナーバージョンは、完全にサポートします
- 最新のマイナーバージョンの 1 つ前は、不具合の修正とセキュリティの更新でサポートします
- 最新のマイナーバージョンの 2 つ前は、重要なセキュリティの更新だけでサポートします

たとえば、Redmine 6.0.0 が最新のバージョンの場合は、次のようになります。

- Redmine 6.0.\* が最新のマイナーバージョンです
- Redmine 5.1.\* は最新のマイナーバージョンの 1 つ前で、不具合の修正とセキュリティの更新が入ります
- Redmine 5.0.\* は最新のマイナーバージョンの 2 つ前で、重要なセキュリティの更新だけが入ります

## ソースコード

Redmine のソースコードは Subversion のリポジトリからチェックアウトできます。最新の改善を取り入れ、簡単にバージョンアップしたい場合は、この方法をお勧めします。

公式の Subversion のリポジトリの URL は https://svn.redmine.org/redmine です。

コミュニティが管理している GitHub のミラーからクローンすることもできます: https://github.com/redmine/redmine

### 7.0 Stable

最新の安定バージョンのソースは、次のコマンドでチェックアウトできます。

**Subversion**

```text
svn co https://svn.redmine.org/redmine/branches/7.0-stable redmine-7.0
```

`redmine-7.0` というディレクトリが作成されます。このディレクトリで `svn update` を実行すると、Redmine を更新できます。

### 開発中のバージョン(不安定)

最新の開発中のソースは、trunk から次のコマンドでチェックアウトできます。

**Subversion**

```text
svn co https://svn.redmine.org/redmine/trunk redmine
```

## サードパーティの Redmine のバンドル

- [TurnKey Redmine Appliance](http://www.turnkeylinux.org/redmine) - Debian をベースにした軽量な Redmine のアプライアンスを無料で提供しています(ISO、仮想マシンのイメージ、クラウドのイメージ)。
- [BitNami Redmine Stack](https://bitnami.com/stack/redmine) – Redmine の仮想マシン、コンテナ、クラウドのイメージを無料で提供しています。
