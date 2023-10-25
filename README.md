tabel_users
| column | type |
| ---- | ---- |
| name | string |
| email | string |
| password_digest | string |

tabel_tasks
| column | type |
| ---- | ---- |
| content | text |
| deadline | string |
| priority | string |
| status | string |
| user_id | bigint |

tabel_labels
| column | type |
| ---- | ---- |
| name | string |

tabel_labelings
| column | type |
| ---- | ---- |
| task_id | bigint |
| label_id | bigint |
