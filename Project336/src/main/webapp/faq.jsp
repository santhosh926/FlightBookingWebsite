<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .faq-header {
            background-color: #f2f2f2;
            padding: 10px;
            cursor: pointer;
        }
        .faq-content {
            padding: 10px;
            display: none;
            border: 1px solid #ddd;
            border-top: none;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .ask-question-box textarea {
            width: 50%;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<h2>Frequently Asked Questions</h2>

<div class="search-box">
    <input type="text" id="searchInput" placeholder="Search for questions...">
</div>

<div class="faq-section">
    <div class="faq-item">
        <div class="faq-header"><strong>Question 1:</strong> How can I cancel my flight reservation?</div>
        <div class="faq-content">
            <p>Flight reservations that have been booked with business class or first class seating can be cancelled on your account's reservations page.</p>
        </div>
    </div>

    <div class="faq-item">
        <div class="faq-header"><strong>Question 2:</strong> What do I do if the flight I want is filled up?</div>
        <div class="faq-content">
            <p>You can join the waitlist for the flight. If the flight opens up, you will be notified.</p>
        </div>
    </div>

    <!-- Add more questions and answers here -->
</div>

<form action=QuestionServ method=post>
<div class="ask-question-box">
    <h3>Couldn't find an answer? Submit your question here!</h3>
    <textarea id="questionInput" placeholder="" rows="4" name="ques"></textarea>
<!--     <button onclick="submitQuestion()">Submit Question</button> -->
	<input type=submit value=Submit>
</div>
</form>

<script>
    document.querySelectorAll('.faq-header').forEach(item => {
        item.addEventListener('click', event => {
            let content = item.nextElementSibling;
            content.style.display = content.style.display === 'block' ? 'none' : 'block';
        });
    });

    document.getElementById('searchInput').addEventListener('keyup', function(event) {
        let searchQuery = event.target.value.toLowerCase();
        document.querySelectorAll('.faq-item').forEach(item => {
            let question = item.querySelector('.faq-header').textContent.toLowerCase();
            if (question.includes(searchQuery)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });
/*     function submitQuestion() {
        var questionInput = document.getElementById('questionInput');
        alert('Your question has been submitted. A customer representative will get back to you soon!"');
        questionInput.value = ''; // Clear the textbox
    } */
</script>
<a href='customer.jsp'>Back to home page</a>



</body>
</html>