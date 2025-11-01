# Transparent Charity Smart Contract on Celo

Một smart contract cho phép tổ chức từ thiện gây quỹ một cách minh bạch trên blockchain Celo. Mọi giao dịch quyên góp đều được ghi lại công khai và có thể tra cứu.

## Tính năng chính

### 1. Quyên góp minh bạch
- Người dùng có thể quyên góp CELO token
- Mỗi lần quyên góp có thể kèm theo tin nhắn ý nghĩa
- Tất cả các giao dịch quyên góp được lưu trữ trên blockchain
- Theo dõi được tổng số tiền đã quyên góp

### 2. Mục tiêu gây quỹ
- Có thể thiết lập mục tiêu gây quỹ cụ thể (ví dụ: 100 CELO)
- Tự động theo dõi tiến độ đạt mục tiêu
- Phát ra sự kiện khi đạt được mục tiêu

### 3. Quản lý quỹ
- Chỉ owner (người tạo contract) mới có quyền rút tiền
- Tiền được rút về địa chỉ beneficiary đã được chỉ định
- Minh bạch trong việc rút tiền với sự kiện FundsWithdrawn

### 4. Tính năng tra cứu
- Xem thông tin chi tiết về một người quyên góp cụ thể
  - Số tiền đã quyên góp
  - Tin nhắn kèm theo
- Xem tiến độ gây quỹ
  - Số tiền hiện tại
  - Mục tiêu cần đạt
  - Phần trăm hoàn thành

## Các sự kiện (Events)

1. `Donated`: Phát ra khi có người quyên góp
   - Địa chỉ người quyên góp
   - Số tiền quyên góp
   - Tin nhắn
   - Thời gian

2. `FundsWithdrawn`: Phát ra khi rút tiền
   - Địa chỉ người nhận
   - Số tiền rút

3. `GoalReached`: Phát ra khi đạt mục tiêu
   - Số tiền mục tiêu đã đạt được

## Cách sử dụng

### Triển khai contract
1. Contract được triển khai với hai tham số:
   - `_beneficiary`: Địa chỉ ví sẽ nhận tiền quyên góp
   - `_goalAmount`: Mục tiêu gây quỹ (tính bằng CELO)

### Quyên góp
Gọi hàm `donate()` với:
- Số CELO muốn quyên góp (gửi qua msg.value)
- Tin nhắn ý nghĩa kèm theo

### Rút tiền
Owner có thể gọi hàm `withdraw()` để rút toàn bộ số tiền về địa chỉ beneficiary.

### Tra cứu thông tin
- `getDonorInfo(address)`: Xem thông tin người quyên góp
- `getProgress()`: Xem tiến độ gây quỹ

## Bảo mật
- Chỉ owner mới có quyền rút tiền
- Tất cả giao dịch đều được lưu trữ trên blockchain
- Không thể thay đổi thông tin quyên góp sau khi đã ghi nhận

## Triển khai trên Celo
Contract này được thiết kế để triển khai trên mạng Celo, một blockchain thân thiện với môi trường và tập trung vào việc tạo ra hệ thống tài chính bao trùm.

## License
MIT