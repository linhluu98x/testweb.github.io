#!/bin/bash

set -e

# Danh sách apps và tiêu đề tương ứng
declare -A apps
apps=(
  [portfolio]="Personal Portfolio"
  [product-landing]="Product Landing Page"
  [cv-online]="Online CV"
  [gallery]="Photo Gallery"
  [blog]="Static Blog"
  [resume-generator]="Resume Generator"
  [todo-list]="To-do List"
  [mini-game]="Mini Game/Quiz"
  [countdown]="Countdown Timer"
  [calculator]="Calculator/Converter"
  [contact-form]="Contact Form (EmailJS)"
  [faq]="FAQ / Product Guide"
)

# Tạo thư mục và file cho từng app
for dir in "${!apps[@]}"; do
  mkdir -p "$dir"
done

# index.html (trang chủ)
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Mini App Gallery</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; }
    h1 { color: #1e90ff; }
    ul { line-height: 2; }
    a { text-decoration: none; color: #1e90ff; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
  <h1>Mini App Gallery</h1>
  <ul>
EOF

for dir in "${!apps[@]}"; do
  echo "    <li><a href=\"$dir/\">${apps[$dir]}</a></li>" >> index.html
done

cat >> index.html <<EOF
  </ul>
  <footer style="margin-top:40px;">&copy; 2025 Mini App Gallery by linhluu98x</footer>
</body>
</html>
EOF

# Nội dung mẫu cho từng app
cat > portfolio/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Personal Portfolio</title>
</head>
<body>
  <h1>Your Name</h1>
  <p>About you, skills, and projects.</p>
  <h2>Projects</h2>
  <ul>
    <li>Project 1</li>
    <li>Project 2</li>
  </ul>
  <h2>Contact</h2>
  <p>Email: you@example.com</p>
</body>
</html>
EOF

cat > product-landing/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Product Landing Page</title>
</head>
<body>
  <h1>Awesome Product</h1>
  <p>Short description of your product or service.</p>
  <form>
    <input type="email" placeholder="Enter your email to subscribe" required>
    <button type="submit">Subscribe</button>
  </form>
</body>
</html>
EOF

cat > cv-online/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Online CV</title>
</head>
<body>
  <h1>Your Name - CV</h1>
  <p>Short bio, education, experience, and more.</p>
  <a href="your-cv.pdf" download>Download PDF</a>
</body>
</html>
EOF

cat > gallery/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Photo Gallery</title>
</head>
<body>
  <h1>Photo Gallery</h1>
  <div>
    <img src="https://placekitten.com/200/200" alt="Pic 1">
    <img src="https://placekitten.com/201/200" alt="Pic 2">
    <img src="https://placekitten.com/202/200" alt="Pic 3">
  </div>
</body>
</html>
EOF

cat > blog/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Static Blog</title>
</head>
<body>
  <h1>My Blog</h1>
  <article>
    <h2>First Post</h2>
    <p>This is your first static blog post.</p>
  </article>
</body>
</html>
EOF

cat > resume-generator/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Resume Generator</title>
  <script>
    function generateResume() {
      const name = document.getElementById('name').value;
      const email = document.getElementById('email').value;
      const result = `Name: ${name}\nEmail: ${email}`;
      document.getElementById('output').textContent = result;
    }
  </script>
</head>
<body>
  <h1>Resume Generator</h1>
  <input id="name" placeholder="Name">
  <input id="email" placeholder="Email">
  <button onclick="generateResume()">Generate</button>
  <pre id="output"></pre>
</body>
</html>
EOF

cat > todo-list/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>To-do List</title>
  <script>
    function addTodo() {
      const val = document.getElementById('todo').value;
      if (!val) return;
      let todos = JSON.parse(localStorage.getItem('todos') || '[]');
      todos.push(val);
      localStorage.setItem('todos', JSON.stringify(todos));
      showTodos();
      document.getElementById('todo').value = '';
    }
    function showTodos() {
      let todos = JSON.parse(localStorage.getItem('todos') || '[]');
      document.getElementById('list').innerHTML = todos.map(t => `<li>${t}</li>`).join('');
    }
    window.onload = showTodos;
  </script>
</head>
<body>
  <h1>To-do List</h1>
  <input id="todo" placeholder="Add new task">
  <button onclick="addTodo()">Add</button>
  <ul id="list"></ul>
</body>
</html>
EOF

cat > mini-game/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Mini Game: Guess the Number</title>
  <script>
    let rnd = Math.floor(Math.random()*10)+1;
    function guess() {
      const val = Number(document.getElementById('num').value);
      const msg = val === rnd ? "Correct!" : "Try again!";
      document.getElementById('result').textContent = msg;
    }
  </script>
</head>
<body>
  <h1>Guess the Number (1-10)</h1>
  <input id="num" type="number" min="1" max="10">
  <button onclick="guess()">Guess</button>
  <div id="result"></div>
</body>
</html>
EOF

cat > countdown/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Countdown Timer</title>
  <script>
    let timer;
    function startCountdown() {
      const sec = parseInt(document.getElementById('seconds').value, 10);
      let t = sec;
      clearInterval(timer);
      document.getElementById('count').textContent = t;
      timer = setInterval(() => {
        t--;
        document.getElementById('count').textContent = t;
        if (t <= 0) clearInterval(timer);
      }, 1000);
    }
  </script>
</head>
<body>
  <h1>Countdown Timer</h1>
  <input id="seconds" type="number" placeholder="Seconds">
  <button onclick="startCountdown()">Start</button>
  <div id="count"></div>
</body>
</html>
EOF

cat > calculator/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Calculator</title>
  <script>
    function calc() {
      const a = parseFloat(document.getElementById('a').value);
      const b = parseFloat(document.getElementById('b').value);
      const op = document.getElementById('op').value;
      let res;
      if(op==='+') res=a+b;
      else if(op==='-') res=a-b;
      else if(op==='*') res=a*b;
      else if(op==='/') res=a/b;
      document.getElementById('result').textContent = `Result: ${res}`;
    }
  </script>
</head>
<body>
  <h1>Simple Calculator</h1>
  <input id="a" type="number">
  <select id="op">
    <option>+</option><option>-</option><option>*</option><option>/</option>
  </select>
  <input id="b" type="number">
  <button onclick="calc()">Calculate</button>
  <div id="result"></div>
</body>
</html>
EOF

cat > contact-form/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Form (EmailJS)</title>
</head>
<body>
  <h1>Contact Form</h1>
  <form id="contact-form">
    <input name="name" placeholder="Your name"><br>
    <input name="email" placeholder="Your email"><br>
    <textarea name="message" placeholder="Your message"></textarea><br>
    <button type="submit">Send</button>
  </form>
  <div id="msg"></div>
  <script src="https://cdn.jsdelivr.net/npm/emailjs-com@2/dist/email.min.js"></script>
  <script>
    (function(){
      emailjs.init('YOUR_USER_ID'); // Replace with your EmailJS user ID
    })();
    document.getElementById('contact-form').onsubmit = function(e) {
      e.preventDefault();
      emailjs.sendForm('YOUR_SERVICE_ID','YOUR_TEMPLATE_ID',this)
        .then(() => document.getElementById('msg').textContent='Sent!', 
              err => document.getElementById('msg').textContent='Error: '+err.text);
    }
  </script>
</body>
</html>
EOF

cat > faq/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>FAQ / Product Guide</title>
</head>
<body>
  <h1>FAQ</h1>
  <details>
    <summary>How do I use this product?</summary>
    <p>Just open the page and follow instructions.</p>
  </details>
  <details>
    <summary>Is it free?</summary>
    <p>Yes, it's 100% free.</p>
  </details>
</body>
</html>
EOF

echo "All mini app skeletons created successfully!"