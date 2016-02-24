%dw 1.0
%output application/json
---
[
  {
    "resourceType": "Observation",
    "subject": {
      "reference": "Patient/example"
    },
    "status": "preliminary",
    "code": {
      "coding": [
        {
          "system": "Internal",
          "code": "86021",
          "display": ""
        }
      ]
    },
    "comments": "",
    "description": "",
    "effectiveDateTime": "2015-31-07"
  }
]