# Step 3 – Inspect the assertions file

The `.assert` file is a plain-text bundle of digitally signed documents called **assertions**. Each assertion carries headers, optional body content, and a cryptographic signature.

## View the full assertions file

```bash
less hello-world_*.assert
```{{exec}}

> Press `q` to quit `less`.

The file contains multiple assertions separated by blank lines. Scan through to notice each block has a `type:` header, an `authority-id:`, various key-value fields, and a base64-encoded signature at the bottom.

## Check which assertion types are present

```bash
grep "^type:" hello-world_*.assert
```{{exec}}

You will see three assertion types:

```
type: account-key
type: snap-declaration
type: snap-revision
```

Here is what each type does:

| Assertion type | Purpose |
|---|---|
| `account-key` | Specifies and verifies the public key used to sign the other assertions |
| `snap-declaration` | Contains key metadata about the snap, including its name, publisher, and which interfaces (if any) are auto-connected |
| `snap-revision` | Acknowledges a specific revision of the snap as received and stored by the Snap Store |

> **Further reading:** [Snap assertions – Ubuntu Core documentation](https://documentation.ubuntu.com/core/reference/assertions/)
