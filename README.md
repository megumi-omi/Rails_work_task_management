users
| column | type |
| ---- | ---- |
| name | string |
| email | string |
| password_digest | string |

tasks
| column | type |
| ---- | ---- |
| content | text |
| deadline | string |
| priority | string |
| status | string |
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