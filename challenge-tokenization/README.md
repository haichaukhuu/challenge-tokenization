# Challenge 1: Tokenization (NFT)

## Thông tin sinh viên

| Thông tin | Chi tiết |
|-----------|----------|
| **Họ và tên** | Khưu Hải Châu |
| **MSSV** | 22120457 |
| **Challenge** | Tokenization - SpeedRunEthereum |

---

## Yêu cầu môi trường

Cài đặt các công cụ sau trước khi bắt đầu:

- **Node.js** >= v20.18.3
- **Yarn** >= v1.22
- **Git**

Kiểm tra phiên bản:

```bash
node -v
yarn -v
git --version
```

---

## Hướng dẫn chạy từng bước

### Bước 1: Clone repository

```bash
git clone https://github.com/haichaukhuu/challenge-tokenization.git
cd challenge-tokenization
```

### Bước 2: Cài đặt dependencies

```bash
yarn install
```

### Bước 3: Chạy blockchain local

Mở **Terminal 1** và chạy:

```bash
yarn chain
```

> Lệnh này khởi động Hardhat Network - một blockchain giả lập trên máy tính của bạn.

### Bước 4: Deploy smart contracts

Mở **Terminal 2** (giữ Terminal 1 đang chạy) và chạy:

```bash
yarn deploy
```

> Lệnh này compile và deploy contract `YourCollectible.sol` lên blockchain local.

### Bước 5: Khởi động frontend

Mở **Terminal 3** và chạy:

```bash
yarn start
```

> Frontend sẽ chạy tại http://localhost:3000
