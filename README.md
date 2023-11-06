users
| column | type |
| ---- | ---- |
| name | string |
| email | string |
| password_digest | string |

tasks
| column | type |
| ---- | ---- |
| title | text |
| content | text |
| deadline | date |
| priority | integer |
| status | integer |
| user_id | bigint |

labels
| column | type |
| ---- | ---- |
| name | string |

labelings
| column | type |
| ---- | ---- |
| task_id | bigint |
| label_id | bigint |

デプロイの手順
1 : $ git add .
2 : $ git commit -m "コミットメッセージ"
3 : $ git push heroku master

使用しているGemのバージョン情報
net-smtp (0.4.0, 0.3.3, default: 0.2.1)
net-imap (0.4.2, 0.4.1, 0.4.0, 0.3.7, 0.3.4, default: 0.1.1)
net-pop (0.1.2, default: 0.1.1)