---
slug: '/'
sidebar_position: 10
---

# Getting Started

The SOSL Lib provides functional constructs for SOSL queries in Apex.

For more details, please refer to the [documentation](https://sosl.beyondthecloud.dev/).

## Examples

```apex
// FIND 'Company' RETURNING Account
List<List<SObject>> searchResults = SOSL.find('Company')
    .returning(SOSL.Returning(Account.SObject))
    .toSearchList();
```

```apex
// FIND 'Company' RETURNING Account(Id, Name ORDER BY Name)
List<List<SObject>> searchResults = SOSL.find('Company')
    .returning(
        SOSL.Returning(Account.SObject)
            .with(Account.Id, Account.Name)
            .orderBy(Account.Name)
    )
    .toSearchList();
```


## Deploy to Salesforce

TBC

## Documentation

[SOSL Lib documentation](https://sosl.beyondthecloud.dev/)

## Features

Read about the features in the [documentation](https://sosl.beyondthecloud.dev/docs/basic-features).

1. **Dynamic SOSL**
2. **Control FLS**
- 2.1 **User Mode**
- 2.2 **System Mode**
- 2.3 **stripInaccessible**
3. **Control Sharings Mode**
- 3.1 **with sharing**
- 3.2 **without sharing**
- 3.3 **inherited sharing**
4. **Mocking**
- 4.1 **Mock list of records**
5. **Dynamic conditions**

----

## License notes

- For proper license management each repository should contain LICENSE file similar to this one.
- Each original class should contain copyright mark: Copyright (c) 2023 BeyondTheCloud.Dev
