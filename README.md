# Lab 2: SpeedRunEthereum Challenges

## Thông tin sinh viên

| Thông tin | Chi tiết |
|-----------|----------|
| **Họ và tên** | Khưu Hải Châu |
| **MSSV** | 22120457 |
| **Lab** | Lab 2 - SpeedRunEthereum Challenges |

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

```

---

## Danh sách các Challenge

| STT | Tên Challenge | Mô tả |
|-----|---------------|-------|
| 1 | challenge-crowdfunding | Ứng dụng góp vốn cộng đồng |
| 2 | challenge-token-vendor | Máy bán token tự động |
| 3 | challenge-dice-game | Trò chơi xúc xắc |
| 4 | challenge-dex | Sàn giao dịch phi tập trung |
| 5 | challenge-over-collateralized-lending | Cho vay thế chấp quá mức |
| 6 | challenge-stablecoins | Stablecoin MyUSD |
| 7 | challenge-tokenization | Token hóa tài sản |

---

## Hướng dẫn chạy chung cho tất cả Challenge

Mỗi challenge đều có cấu trúc giống nhau và chạy theo các bước sau:

### Bước 1: Di chuyển vào thư mục challenge

```bash
cd challenge-<tên-challenge>
```

Ví dụ:
```bash
cd challenge-crowdfunding
cd challenge-token-vendor
cd challenge-dice-game
cd challenge-dex
cd challenge-over-collateralized-lending
cd challenge-stablecoins
cd challenge-tokenization
```

### Bước 2: Cài đặt dependencies

```bash
yarn install
```

### Bước 3: Chạy blockchain local

Mở Terminal 1 và chạy:

```bash
yarn chain
```

Lệnh này khởi động Hardhat Network — một blockchain giả lập trên máy tính.

### Bước 4: Deploy smart contracts

Mở Terminal 2 (giữ Terminal 1 đang chạy) và chạy:

```bash
yarn deploy
```

Lệnh này compile và deploy các smart contract lên blockchain local.

Nếu muốn deploy lại từ đầu:

```bash
yarn deploy --reset
```

### Bước 5: Khởi động frontend

Mở Terminal 3 và chạy:

```bash
yarn start
```

Frontend sẽ chạy tại http://localhost:3000

### Bước 6: Chạy test (tùy chọn)

```bash
yarn test
```

---

## Chi tiết từng Challenge

### 1. Challenge Crowdfunding

**Thư mục:** `challenge-crowdfunding`

**Mô tả:** Ứng dụng góp vốn cộng đồng cho phép người dùng đóng góp ETH, rút tiền nếu thất bại, và thực thi khi đạt mục tiêu.

**Các hàm chính:**
- `contribute()`: Nhận ETH từ người dùng
- `withdraw()`: Hoàn tiền nếu crowdfunding thất bại
- `execute()`: Thực thi khi đạt mục tiêu và hết deadline
- `receive()`: Nhận ETH trực tiếp

---

### 2. Challenge Token Vendor

**Thư mục:** `challenge-token-vendor`

**Mô tả:** Máy bán token tự động cho phép mua/bán token bằng ETH.

**Các hàm chính:**
- `buyTokens()`: Mua token bằng ETH
- `sellTokens()`: Bán token lấy ETH
- `withdraw()`: Rút ETH từ contract

---

### 3. Challenge Dice Game

**Thư mục:** `challenge-dice-game`

**Mô tả:** Trò chơi xúc xắc sử dụng số ngẫu nhiên. Người chơi đặt cược và thắng nếu đoán đúng.

**Các hàm chính:**
- `rollDice()`: Tung xúc xắc và xử lý cược

---

### 4. Challenge DEX

**Thư mục:** `challenge-dex`

**Mô tả:** Sàn giao dịch phi tập trung cho phép swap giữa ETH và token.

**Các hàm chính:**
- `init()`: Khởi tạo liquidity pool
- `ethToToken()`: Đổi ETH sang token
- `tokenToEth()`: Đổi token sang ETH
- `deposit()`: Thêm liquidity
- `withdraw()`: Rút liquidity

---

### 5. Challenge Over-Collateralized Lending

**Thư mục:** `challenge-over-collateralized-lending`

**Mô tả:** Hệ thống cho vay thế chấp quá mức. Người dùng gửi collateral để vay token.

**Các hàm chính:**
- `depositCollateral()`: Gửi tài sản thế chấp
- `withdrawCollateral()`: Rút tài sản thế chấp
- `borrow()`: Vay token
- `repay()`: Trả nợ
- `liquidate()`: Thanh lý khi vị thế không an toàn

---

### 6. Challenge Stablecoins

**Thư mục:** `challenge-stablecoins`

**Mô tả:** Xây dựng stablecoin MyUSD được đảm bảo bằng ETH. Bao gồm các cơ chế mint, burn, lãi suất và thanh lý.

**Các hàm chính:**
- `addCollateral()`: Gửi ETH làm tài sản đảm bảo
- `withdrawCollateral()`: Rút ETH
- `mintMyUSD()`: Mint stablecoin
- `repayUpTo()`: Trả nợ
- `liquidate()`: Thanh lý vị thế không an toàn
- `setBorrowRate()`: Đặt lại suất vay

**Lệnh đặc biệt:**
```bash
yarn simulate
```
Chạy mô phỏng thị trường với các bot tự động.

---

### 7. Challenge Tokenization

**Thư mục:** `challenge-tokenization`

**Mô tả:** Token hóa tài sản thực tế thành token trên blockchain.

**Các hàm chính:**
- Tạo token
- Chuyển và phê duyệt
- Quản lý tài sản

---

## Cấu trúc thư mục chung

Mỗi challenge có cấu trúc:

```
challenge-<tên>/
  packages/
    hardhat/           # Smart contracts
      contracts/       # Các file .sol
      deploy/          # Scripts deploy
      test/            # Unit tests
    nextjs/            # Frontend
      app/             # Các trang
      components/      # Components
  package.json
  README.md
```

---

## Các lệnh thường dùng

| Lệnh | Mô tả |
|------|-------|
| `yarn chain` | Chạy blockchain local |
| `yarn deploy` | Deploy contracts |
| `yarn deploy --reset` | Deploy lại từ đầu |
| `yarn start` | Chạy frontend |
| `yarn test` | Chạy unit tests |
| `yarn compile` | Compile contracts |

---

## Lưu ý

1. Luôn chạy `yarn chain` trước khi deploy
2. Mở 3 terminal riêng biệt cho chain, deploy và start
3. Sau khi sửa contract, chạy `yarn deploy --reset` để cập nhật
4. Frontend tự động reload khi contract thay đổi
4. Frontend tu dong reload khi contract thay doi
