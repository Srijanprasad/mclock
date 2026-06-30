# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| 0.x.x   | :white_check_mark: (pre-release) |

## Reporting a Vulnerability

We take the security of mclock seriously. If you discover a security vulnerability, please report it responsibly.

**Please do not report security vulnerabilities through public GitHub issues.**

### How to Report

1. Email **security@mclock.dev** with:
   - A description of the vulnerability
   - Steps to reproduce
   - Potential impact assessment
   - Any suggested fix (optional)

2. You will receive an acknowledgment within **48 hours**

3. We will investigate and provide a timeline for a fix within **7 days**

### What to Expect

- We will confirm receipt of your report promptly
- We will keep you informed of our progress
- We will credit you in the release notes (unless you prefer to remain anonymous)
- We will not take legal action against researchers who follow responsible disclosure

### Scope

The following are in scope:

- Authentication bypass in lock screen
- Privilege escalation
- Data exposure (settings, credentials)
- Code injection via plugins or themes
- Denial of service affecting system stability

The following are out of scope:

- Social engineering attacks
- Physical access attacks
- Issues in third-party dependencies (report to the upstream project)
- Issues requiring jailbroken or modified macOS

### Security Best Practices for Contributors

- Never commit secrets, API keys, or credentials
- Validate all user input in plugin and theme loading
- Use Keychain Services for credential storage
- Follow the principle of least privilege for entitlements
- Run `swiftlint` security rules before submitting PRs

## Security Updates

Security fixes are released as patch versions (e.g., v1.0.1) and announced via:

- GitHub Security Advisories
- CHANGELOG.md
- GitHub Release notes
