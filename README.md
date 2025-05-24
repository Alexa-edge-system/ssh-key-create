# Alexa-edge system's 
## 🔐 GitHub SSH Key Setup Script

This Bash script automates the process of generating an SSH key pair, uploading the public key to your GitHub account using a Personal Access Token (PAT), configuring your SSH client, and testing the connection.

### ✅ Features

* Automatically generates a 4096-bit RSA SSH key
* Adds the private key to the SSH agent
* Uploads the public key to your GitHub account
* Configures SSH for seamless GitHub access
* Verifies SSH authentication to GitHub

---

### 📦 Prerequisites

* Bash shell (Linux/macOS)
* `ssh` and `ssh-agent`
* `curl` installed
* A valid **GitHub Personal Access Token (PAT)** with the `write:public_key` scope

---

### 🚀 How to Use

1. **Save the script** to a file, e.g. `setup-github-ssh.sh`

2. **Make it executable**:

   ```bash
   chmod +x keygen.sh
   ```

3. **Run the script**:

   ```bash
   ./setup-github-ssh.sh
   ```

4. **Input the following when prompted**:

   * GitHub username
   * GitHub email
   * GitHub PAT (input hidden for security)

---

### 🗂️ Files Created

* SSH key pair:

  * `~/.ssh/github_id_rsa` (private key)
  * `~/.ssh/github_id_rsa.pub` (public key)
* SSH config entry in `~/.ssh/config` for `github.com`

---

### 🧪 Test Output

After successful setup, you’ll see:

```bash
✅ SSH key added. Testing GitHub SSH access:
Hi <your-username>! You've successfully authenticated, but GitHub does not provide shell access.
```

---

### 🔐 Security Notes

* Your GitHub PAT is not stored anywhere
* Private SSH key permissions remain secure (`600`)
* Public key is uploaded via HTTPS using GitHub API

---

### 🧹 Optional Cleanup

To remove the key:

```bash
rm ~/.ssh/github_id_rsa ~/.ssh/github_id_rsa.pub
```

Manually remove the entry from GitHub and `~/.ssh/config` if needed.

---

### 📄 License


---

Let me know if you'd like this README in markdown file format (`README.md`).
