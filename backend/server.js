const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Database connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'aniqueul85hassan',
    database: 'lifesyncdb'
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL Connected...');
});

// User sign-up
app.post('/signup', async (req, res) => {
    const { name, email, password } = req.body;
    console.log('Received sign-up request:', req.body);

    if (!name || !email || !password) {
        return res.status(400).json({ status: 'error', message: 'All fields are required' });
    }

    try {
        db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
            if (err) {
                console.error('Database Error:', err);
                return res.status(500).json({ status: 'error', message: 'Database error', error: err.sqlMessage });
            }

            if (results.length > 0) {
                console.log('Email already exists:', email);
                return res.status(409).json({ status: 'error', message: 'Email already in use' });
            }

            const hashedPassword = await bcrypt.hash(password, 10);
            db.query(
                'INSERT INTO users (full_name, email, password_hash) VALUES (?, ?, ?)',
                [name, email, hashedPassword],
                (err, result) => {
                    if (err) {
                        console.error('Error inserting into database:', err);
                        return res.status(500).json({ status: 'error', message: 'Database error', error: err.sqlMessage });
                    }
                    console.log('User registered successfully');
                    return res.status(201).json({ status: 'success', message: 'User registered successfully!' });
                }
            );
        });
    } catch (error) {
        console.error('Signup Error:', error);
        res.status(500).json({ status: 'error', message: 'Server error', error: error.message });
    }
});



// User login
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    console.log('Received login request:', req.body);

    db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(401).json({ status: 'error', message: 'Invalid email or password' });
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.password_hash);

        if (!isMatch) {
            return res.status(401).json({ status: 'error', message: 'Invalid email or password' });
        }

        const token = jwt.sign({ id: user.id }, 'secretkey', { expiresIn: '1h' });
        res.json({ status: 'success', message: 'Login successful', token });
    });
});

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
