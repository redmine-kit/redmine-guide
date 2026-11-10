---
source: RedmineReminderEmails
translated_from_version: 15
---

# リマインダーメールの送信

Redmine には、担当していて未完了のチケットのうち、期日を過ぎたものと、指定した日数以内に期日が来るものについて、リマインダーメールを送る rake タスクがあります。

使えるオプションは次のとおりです。

- days: 何日先までのチケットを通知するか(デフォルトは 7)
- tracker: トラッカーの ID(デフォルトはすべてのトラッカー)
- project: プロジェクトの ID または識別子(デフォルトはすべてのプロジェクト)
- users: 通知するユーザーまたはグループの ID のカンマ区切りの一覧
- version: チケットを絞り込む対象バージョンの名前(デフォルトは指定なし)

次の例は、期日を過ぎたチケットか 7 日以内に期日が来るチケットを担当しているユーザーそれぞれに、メールを送ります。

    bundle exec rake redmine:send_reminders days=7 RAILS_ENV="production"

次の例は、期日を過ぎたチケットか **7 日以内**に期日が来るチケットを担当しているユーザー **1**、**23**、**56** に、メールを送ります。

    bundle exec rake redmine:send_reminders days=7 users="1,23,56" RAILS_ENV="production"

crontab に登録するときは、rake のコマンドを小さなスクリプトにまとめます。例:

    #!/bin/bash
    cd /usr/local/share/redmine
    bundle exec rake redmine:send_reminders days=7 RAILS_ENV="production"
