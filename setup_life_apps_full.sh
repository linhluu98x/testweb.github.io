#!/bin/bash
set -e

declare -A apps
apps=(
  [expense-tracker]="Quản lý chi tiêu cá nhân|Theo dõi thu/chi, tổng kết và lưu lịch sử chi tiêu cá nhân."
  [habit-tracker]="Theo dõi thói quen|Tạo và đánh dấu các thói quen tích cực mỗi ngày."
  [todo-list]="Nhắc việc, to-do list|Lập danh sách việc cần làm, đánh dấu hoàn thành từng mục."
  [quick-notes]="Ghi chú nhanh|Ghi chú ý tưởng, công việc hoặc thông tin quan trọng, lưu trữ ngay trên thiết bị."
  [countdown-timer]="Đồng hồ đếm ngược|Đặt giờ đếm ngược cho các sự kiện, công việc, nấu ăn, tập luyện."
  [pomodoro]="Lập kế hoạch Pomodoro|Chia nhỏ thời gian làm việc/học tập để tăng hiệu suất."
  [health-calculator]="Máy tính sức khỏe (BMI/BMR)|Tính chỉ số BMI & BMR để theo dõi sức khỏe."
  [sleep-cycle]="Tính giờ ngủ khoa học|Tính toán giờ nên thức giấc hoặc đi ngủ hợp lý theo chu kỳ ngủ."
  [water-reminder]="Lịch nhắc uống nước|Theo dõi và nhắc nhở uống nước đầy đủ mỗi ngày."
  [unit-converter]="Chuyển đổi đơn vị|Đổi đơn vị chiều dài, khối lượng, nhiệt độ, ..."
  [qr-generator]="Tạo mã QR nhanh|Tạo mã QR từ văn bản hoặc liên kết để chia sẻ nhanh chóng."
  [step-tracker]="Nhật ký bước chân|Ghi lại số bước, thống kê vận động mỗi ngày."
  [simple-passwords]="Quản lý mật khẩu đơn giản|Lưu trữ mật khẩu offline, chỉ lưu trên thiết bị cá nhân."
  [mood-tracker]="Theo dõi cảm xúc|Đánh dấu cảm xúc mỗi ngày, tạo nhật ký tâm trạng."
  [calorie-log]="Nhật ký thực phẩm/Calories|Nhập món ăn, lượng calo để quản lý chế độ ăn uống."
  [shopping-list]="Danh sách mua sắm|Lên danh sách các món cần mua, tích chọn khi đã mua."
  [goal-setter]="Đặt mục tiêu cá nhân|Lập mục tiêu, checklist, đánh dấu hoàn thành."
  [stopwatch]="Đồng hồ bấm giờ|Đo thời gian sự kiện, bấm giờ thể thao."
  [tip-split]="Tính tiền tip/chia hóa đơn|Tính tiền tip và chia hóa đơn cho nhóm."
  [color-converter]="Bảng chuyển đổi màu sắc|Đổi mã màu HEX, RGB, HSL, xem bảng màu."
)

# Trang chủ
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Life Suite - Ứng dụng hữu ích cho cuộc sống</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    html { box-sizing: border-box; }
    *, *:before, *:after { box-sizing: inherit; }
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #e3eafc; margin:0; }
    .container { max-width: 980px; margin: 0 auto; padding: 36px 14px 60px 14px;}
    h1 { font-size:2.2em; color: #1976d2; text-align: center; margin-bottom: 0.2em;}
    h2 { color: #333; font-size: 1.12em; margin: 0 0 0.2em 0; }
    .desc {color:#555; font-size:1em; margin-bottom: 0.5em;}
    .grid { display: grid; grid-template-columns: repeat(auto-fit,minmax(260px,1fr)); gap: 22px; margin-top:26px; }
    .card { background: #fff; border-radius: 11px; box-shadow: 0 2px 12px #0001; padding: 18px 15px 16px 15px; transition:transform .16s; border:2px solid #f3f6fd;}
    .card:hover { transform: translateY(-7px) scale(1.03); border-color: #1976d2; }
    .card a { color: #1976d2; text-decoration: none; font-weight: bold; font-size:1.06em;}
    .card a:after {content:" →"; font-weight: normal;}
    @media (max-width:600px) {
      .container { padding: 14px 2vw; }
      .grid { gap: 10px; }
      .card {padding: 10px 5px 12px 8px;}
    }
    footer {margin-top:28px;text-align:center;color:#b6b6b6;font-size:.98em;}
  </style>
</head>
<body>
  <div class="container">
    <h1>Life Suite</h1>
    <div style="text-align:center;font-size:1.13em;color:#555;max-width:700px;margin:0 auto 16px auto;">
      Bộ sưu tập ứng dụng nhỏ, miễn phí, tiện ích – tối ưu giao diện cho cả máy tính và điện thoại. Mọi dữ liệu lưu trên thiết bị cá nhân, an toàn & bảo mật.
    </div>
    <div class="grid">
EOF

for dir in "${!apps[@]}"; do
  name="${apps[$dir]%%|*}"
  desc="${apps[$dir]#*|}"
  echo "      <div class=\"card\"><h2>$name</h2><div class=\"desc\">$desc</div><a href=\"$dir/\">Truy cập</a></div>" >> index.html
done

cat >> index.html <<EOF
    </div>
    <footer>&copy; 2025 Life Suite by linhluu98x</footer>
  </div>
</body>
</html>
EOF

# App 1: Quản lý chi tiêu cá nhân
mkdir -p expense-tracker
cat > expense-tracker/index.html <<'EOF'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý chi tiêu cá nhân - Life Suite</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body { background:#f4f6fb; margin:0; font-family:'Segoe UI',Arial,sans-serif;}
    .wrap { max-width:430px; margin:36px auto; background:#fff; border-radius:12px; box-shadow:0 2px 14px #0001; padding:28px 18px;}
    h1 { text-align:center; color:#1976d2; margin:12px 0 16px 0; }
    .form-row { display: flex; gap: 8px; margin-bottom: 14px;}
    .form-row input { flex:1; font-size:1.05em; padding:8px; border:1px solid #ccc; border-radius:5px;}
    .form-row button { padding:8px 16px; background:#1976d2; color:#fff; border:none; border-radius:5px; cursor:pointer;}
    .form-row button:hover { background:#1565c0;}
    ul {list-style:none;padding:0;margin:0;}
    li {padding:9px 0;display:flex;justify-content:space-between;align-items:center;border-bottom:1px dotted #eee;}
    .sum { font-weight:bold; color:#1976d2; text-align:right; margin-top:10px;}
    .desc{color:#555;text-align:center;margin-bottom:14px;}
    .del{color:#e53935;text-decoration:none;font-size:1.1em;margin-left:10px;}
    @media(max-width:600px){.wrap{padding:7vw 2vw;}}
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Quản lý chi tiêu</h1>
    <div class="desc">Theo dõi thu/chi, tổng kết và lưu lịch sử chi tiêu cá nhân.</div>
    <form id="form" class="form-row" autocomplete="off">
      <input type="text" id="desc" placeholder="Mô tả" required>
      <input type="number" id="amount" placeholder="Số tiền" required>
      <button type="submit">Thêm</button>
    </form>
    <ul id="list"></ul>
    <div class="sum" id="total">Tổng: 0 đ</div>
    <div style="text-align:center;margin-top:28px;">
      <a href="../" style="color:#1976d2;text-decoration:none;font-size:.97em;">&larr; Về trang chủ</a>
    </div>
  </div>
  <script>
    function save(data){localStorage.setItem('expenses',JSON.stringify(data));}
    function load(){return JSON.parse(localStorage.getItem('expenses')||'[]');}
    function render(){let d=load(),s=0;
      list.innerHTML=d.map((x,i)=>`<li>${x.desc}<span>${parseInt(x.amount).toLocaleString()} đ
      <a href="#" class="del" onclick="del(${i});return false;" title="Xóa">🗑</a></span></li>`).join('');
      d.forEach(x=>s+=+x.amount);
      total.textContent='Tổng: '+s.toLocaleString()+' đ';
    }
    form.onsubmit=e=>{
      e.preventDefault();
      let d=load(); d.push({desc:desc.value,amount:amount.value}); save(d); render();
      desc.value=''; amount.value=''; desc.focus();
    };
    window.del=i=>{let d=load();d.splice(i,1);save(d);render();}
    render();
  </script>
</body>
</html>
EOF

# App 2: Theo dõi thói quen
mkdir -p habit-tracker
cat > habit-tracker/index.html <<'EOF'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Theo dõi thói quen - Life Suite</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {background:#f4f6fb;font-family:'Segoe UI',Arial,sans-serif;}
    .wrap {max-width:430px;margin:36px auto;background:#fff;border-radius:12px;box-shadow:0 2px 14px #0001;padding:28px 18px;}
    h1 {text-align:center;color:#43a047;}
    .desc{color:#555;text-align:center;margin-bottom:14px;}
    .form-row {display:flex;gap:8px;margin-bottom:12px;}
    .form-row input {flex:1;font-size:1.05em;padding:8px;border:1px solid #ccc;border-radius:5px;}
    .form-row button {padding:8px 16px;background:#43a047;color:#fff;border:none;border-radius:5px;cursor:pointer;}
    .form-row button:hover {background:#2e7d32;}
    ul {list-style:none;padding:0;margin:0;}
    li {padding:8px 0;display:flex;justify-content:space-between;align-items:center;border-bottom:1px dotted #eee;}
    .done {text-decoration:line-through;color:#aaa;}
    .del{color:#e53935;text-decoration:none;font-size:1.1em;margin-left:10px;}
    @media(max-width:600px){.wrap{padding:7vw 2vw;}}
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Theo dõi thói quen</h1>
    <div class="desc">Tạo và đánh dấu các thói quen tích cực mỗi ngày.</div>
    <form id="form" class="form-row" autocomplete="off">
      <input type="text" id="habit" placeholder="Tên thói quen..." required>
      <button type="submit">Thêm</button>
    </form>
    <ul id="list"></ul>
    <div style="text-align:center;margin-top:28px;">
      <a href="../" style="color:#1976d2;text-decoration:none;font-size:.97em;">&larr; Về trang chủ</a>
    </div>
  </div>
  <script>
    function save(d){localStorage.setItem('habits',JSON.stringify(d));}
    function load(){return JSON.parse(localStorage.getItem('habits')||'[]');}
    function render(){let d=load();
      list.innerHTML=d.map((x,i)=>`<li>
      <span class="${x.done?'done':''}" onclick="toggle(${i})" style="cursor:pointer">${x.name}</span>
      <a href="#" class="del" onclick="del(${i});return false;" title="Xóa">🗑</a>
      </li>`).join('');
    }
    form.onsubmit=e=>{
      e.preventDefault();
      let d=load();d.push({name:habit.value,done:false});save(d);habit.value='';render();
    };
    window.del=i=>{let d=load();d.splice(i,1);save(d);render();}
    window.toggle=i=>{let d=load();d[i].done=!d[i].done;save(d);render();}
    render();
  </script>
</body>
</html>
EOF

# App 3: Nhắc việc, to-do list
mkdir -p todo-list
cat > todo-list/index.html <<'EOF'
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>To-do List - Life Suite</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {background:#f4f6fb;font-family:'Segoe UI',Arial,sans-serif;}
    .wrap{max-width:430px;margin:36px auto;background:#fff;border-radius:12px;box-shadow:0 2px 14px #0001;padding:28px 18px;}
    h1{text-align:center;color:#e65100;}
    .desc{color:#555;text-align:center;margin-bottom:14px;}
    .form-row{display:flex;gap:8px;margin-bottom:12px;}
    .form-row input{flex:1;font-size:1.05em;padding:8px;border:1px solid #ccc;border-radius:5px;}
    .form-row button{padding:8px 16px;background:#e65100;color:#fff;border:none;border-radius:5px;cursor:pointer;}
    .form-row button:hover{background:#bf360c;}
    ul{list-style:none;padding:0;margin:0;}
    li{padding:8px 0;display:flex;justify-content:space-between;align-items:center;border-bottom:1px dotted #eee;}
    .done{text-decoration:line-through;color:#aaa;}
    .del{color:#e53935;text-decoration:none;font-size:1.1em;margin-left:10px;}
    @media(max-width:600px){.wrap{padding:7vw 2vw;}}
  </style>
</head>
<body>
  <div class="wrap">
    <h1>To-do List</h1>
    <div class="desc">Lập danh sách việc cần làm, đánh dấu hoàn thành từng mục.</div>
    <form id="form" class="form-row" autocomplete="off">
      <input type="text" id="todo" placeholder="Việc cần làm..." required>
      <button type="submit">Thêm</button>
    </form>
    <ul id="list"></ul>
    <div style="text-align:center;margin-top:28px;">
      <a href="../" style="color:#1976d2;text-decoration:none;font-size:.97em;">&larr; Về trang chủ</a>
    </div>
  </div>
  <script>
    function save(d){localStorage.setItem('todos',JSON.stringify(d));}
    function load(){return JSON.parse(localStorage.getItem('todos')||'[]');}
    function render(){let d=load();
      list.innerHTML=d.map((x,i)=>`<li>
      <span class="${x.done?'done':''}" onclick="toggle(${i})" style="cursor:pointer">${x.name}</span>
      <a href="#" class="del" onclick="del(${i});return false;" title="Xóa">🗑</a>
      </li>`).join('');
    }
    form.onsubmit=e=>{
      e.preventDefault();
      let d=load();d.push({name:todo.value,done:false});save(d);todo.value='';render();
    };
    window.del=i=>{let d=load();d.splice(i,1);save(d);render();}
    window.toggle=i=>{let d=load();d[i].done=!d[i].done;save(d);render();}
    render();
  </script>
</body>
</html>
EOF

# ... (Các app phổ biến tiếp theo: quick-notes, countdown-timer, pomodoro, ... bạn tiếp tục làm tương tự!)

# ===> Do giới hạn ký tự, mình sẽ gửi tiếp các app còn lại (quick-notes, countdown-timer, pomodoro, health-calculator, sleep-cycle, water-reminder, unit-converter, qr-generator, step-tracker, simple-passwords, mood-tracker, calorie-log, shopping-list, goal-setter, stopwatch, tip-split, color-converter) ở các reply tiếp theo.  
**Bạn chỉ cần ghép lại toàn bộ là thành trọn bộ script hoàn chỉnh.**  
Nếu muốn nhận từng app HTML riêng lẻ, hãy yêu cầu từng app cụ thể.