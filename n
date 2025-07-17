<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encontro no Cinema: Superman!</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #fce7f3; /* Light pink background */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .pink-primary {
            background-color: #f472b6; /* Medium pink */
        }
        .pink-text-dark {
            color: #db2777; /* Darker pink text */
        }
        .superman-blue-text {
            color: #007bff; /* Superman blue */
        }
        .superman-red-text {
            color: #dc3545; /* Superman red */
        }
        .superman-yellow-text {
            color: #ffc107; /* Superman yellow */
        }
        .day-cell {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            padding-top: 100%; /* Makes cells square */
            position: relative;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.2s ease-in-out, transform 0.2s ease-in-out;
        }
        .day-cell span {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-weight: 600;
        }
        .day-cell:not(.disabled):hover {
            background-color: #fbcfe8; /* Lighter pink on hover */
            transform: scale(1.05);
        }
        .day-cell.selected {
            background-color: #ec4899; /* Darker pink when selected */
            color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .day-cell.disabled {
            background-color: #e5e7eb;
            color: #9ca3af;
            cursor: not-allowed;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
            text-align: center;
            position: relative;
        }
        .close-button {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="pink-primary text-white p-4 shadow-md rounded-b-xl">
        <div class="container mx-auto flex flex-col items-center">
            <h1 class="text-3xl font-bold tracking-wide">Encontro no Cinema!</h1>
            <!-- Subtle Superman-like icon -->
            <div class="text-5xl font-extrabold superman-yellow-text drop-shadow-lg mt-2">
                <span class="superman-red-text">S</span>
                <span class="superman-blue-text">!</span>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow container mx-auto p-6 flex flex-col items-center justify-center">

        <!-- Initial Question Section -->
        <section id="initialQuestion" class="bg-white p-8 rounded-2xl shadow-xl max-w-lg w-full text-center border-4 border-pink-primary">
            <h2 class="text-3xl font-semibold pink-text-dark mb-6">Ainda tá a fim de ir ao cinema comigo?</h2>
            <div class="flex justify-center gap-4">
                <button id="yesButton" class="pink-primary hover:bg-pink-600 text-white font-bold py-3 px-8 rounded-full shadow-lg transition duration-300 ease-in-out transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-pink-300">
                    Sim!
                </button>
                <button id="noButton" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-3 px-8 rounded-full shadow-lg transition duration-300 ease-in-out transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-gray-200">
                    Não
                </button>
            </div>
        </section>

        <!-- Calendar Section (initially hidden) -->
        <section id="calendarSection" class="hidden bg-white p-8 rounded-2xl shadow-xl max-w-2xl w-full text-center border-4 border-pink-primary mt-8">
            <h2 class="text-3xl font-semibold pink-text-dark mb-6">Escolha um dia em Julho</h2>
            <div class="text-xl font-bold mb-4">Julho 2025</div>
            <div id="calendarGrid" class="grid grid-cols-7 gap-2 text-gray-700">
                <div class="font-bold text-center">Dom</div>
                <div class="font-bold text-center">Seg</div>
                <div class="font-bold text-center">Ter</div>
                <div class="font-bold text-center">Qua</div>
                <div class="font-bold text-center">Qui</div>
                <div class="font-bold text-center">Sex</div>
                <div class="font-bold text-center">Sáb</div>
                <!-- Calendar days will be inserted here by JS -->
            </div>
        </section>

        <!-- Message Section (for "Não" or other messages) -->
        <section id="messageSection" class="hidden bg-white p-8 rounded-2xl shadow-xl max-w-lg w-full text-center border-4 border-pink-primary mt-8">
            <h2 id="messageText" class="text-2xl font-semibold pink-text-dark"></h2>
        </section>
    </main>

    <!-- Time Selection Modal -->
    <div id="timeModal" class="modal">
        <div class="modal-content">
            <span class="close-button" id="closeTimeModalButton">&times;</span>
            <h2 class="text-2xl font-bold pink-text-dark mb-4">Escolha um horário para <span id="selectedDateText"></span></h2>
            <div class="flex flex-wrap justify-center gap-4" id="timeButtonsContainer">
                <!-- Time buttons will be inserted here by JS -->
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirmationModal" class="modal">
        <div class="modal-content">
            <span class="close-button" id="closeConfirmationModalButton">&times;</span>
            <h2 class="text-3xl font-bold pink-text-dark mb-4">Encontro Sugerido!</h2>
            <p id="finalMessage" class="text-xl text-gray-800 mb-6"></p>
            <button id="okFinalButton" class="pink-primary hover:bg-pink-600 text-white font-bold py-2 px-6 rounded-full transition duration-300 ease-in-out">
                Ok!
            </button>
        </div>
    </div>

    <!-- Footer -->
    <footer class="pink-primary text-white p-4 text-center mt-8 rounded-t-xl">
        <p>&copy; 2025 Encontro no Cinema. Feito com carinho.</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const initialQuestion = document.getElementById('initialQuestion');
            const yesButton = document.getElementById('yesButton');
            const noButton = document.getElementById('noButton');
            const calendarSection = document.getElementById('calendarSection');
            const calendarGrid = document.getElementById('calendarGrid');
            const messageSection = document.getElementById('messageSection');
            const messageText = document.getElementById('messageText');
            const timeModal = document.getElementById('timeModal');
            const closeTimeModalButton = document.getElementById('closeTimeModalButton');
            const selectedDateText = document.getElementById('selectedDateText');
            const timeButtonsContainer = document.getElementById('timeButtonsContainer');
            const confirmationModal = document.getElementById('confirmationModal');
            const closeConfirmationModalButton = document.getElementById('closeConfirmationModalButton');
            const finalMessage = document.getElementById('finalMessage');
            const okFinalButton = document.getElementById('okFinalButton');

            let selectedDate = null; // To store the date selected from the calendar

            // Current date to disable past days
            const today = new Date();
            const currentYear = today.getFullYear();
            const currentMonth = today.getMonth(); // 0-indexed (July is 6)
            const currentDay = today.getDate(); // 17 for July 17th

            // Event listener for "Sim" button
            yesButton.addEventListener('click', () => {
                initialQuestion.classList.add('hidden');
                messageSection.classList.add('hidden'); // Hide any previous messages
                calendarSection.classList.remove('hidden');
                generateCalendar(2025, 6); // Generate calendar for July (month 6 is July)
            });

            // Event listener for "Não" button
            noButton.addEventListener('click', () => {
                initialQuestion.classList.add('hidden');
                calendarSection.classList.add('hidden');
                messageSection.classList.remove('hidden');
                messageText.textContent = 'Que pena! Quem sabe na próxima?';
            });

            // Function to generate the calendar
            function generateCalendar(year, month) {
                calendarGrid.innerHTML = `
                    <div class="font-bold text-center">Dom</div>
                    <div class="font-bold text-center">Seg</div>
                    <div class="font-bold text-center">Ter</div>
                    <div class="font-bold text-center">Qua</div>
                    <div class="font-bold text-center">Qui</div>
                    <div class="font-bold text-center">Sex</div>
                    <div class="font-bold text-center">Sáb</div>
                `; // Reset grid and add day names

                const firstDayOfMonth = new Date(year, month, 1);
                const daysInMonth = new Date(year, month + 1, 0).getDate();
                const startDay = firstDayOfMonth.getDay(); // 0 for Sunday, 1 for Monday, etc.

                // Add empty cells for days before the 1st of the month
                for (let i = 0; i < startDay; i++) {
                    const emptyCell = document.createElement('div');
                    emptyCell.classList.add('day-cell', 'disabled');
                    calendarGrid.appendChild(emptyCell);
                }

                // Add days of the month
                for (let day = 1; day <= daysInMonth; day++) {
                    const dayCell = document.createElement('div');
                    dayCell.classList.add('day-cell', 'bg-gray-100', 'text-gray-800', 'hover:text-pink-text-dark');
                    dayCell.innerHTML = `<span>${day}</span>`;

                    const fullDate = new Date(year, month, day);

                    // Disable past dates (before today)
                    if (fullDate < new Date(currentYear, currentMonth, currentDay)) {
                        dayCell.classList.add('disabled');
                    } else {
                        dayCell.addEventListener('click', () => {
                            // Remove selected class from previously selected day
                            const previouslySelected = document.querySelector('.day-cell.selected');
                            if (previouslySelected) {
                                previouslySelected.classList.remove('selected');
                                previouslySelected.classList.add('bg-gray-100'); // Restore original background
                                previouslySelected.classList.remove('text-white'); // Restore original text color
                            }

                            // Add selected class to the clicked day
                            dayCell.classList.add('selected');
                            dayCell.classList.remove('bg-gray-100'); // Remove original background
                            dayCell.classList.add('text-white'); // Set text to white for selected

                            selectedDate = fullDate;
                            showTimeSelectionModal(fullDate);
                        });
                    }
                    calendarGrid.appendChild(dayCell);
                }
            }

            // Function to show time selection modal
            function showTimeSelectionModal(date) {
                const options = { weekday: 'long', month: 'long', day: 'numeric' };
                selectedDateText.textContent = date.toLocaleDateString('pt-BR', options);
                timeButtonsContainer.innerHTML = ''; // Clear previous buttons

                const availableTimes = ['15:00', '16:00', '17:00', '18:00'];

                availableTimes.forEach(time => {
                    const timeButton = document.createElement('button');
                    timeButton.classList.add('pink-primary', 'hover:bg-pink-600', 'text-white', 'font-bold', 'py-2', 'px-6', 'rounded-full', 'shadow-md', 'transition', 'duration-200', 'ease-in-out', 'transform', 'hover:scale-105');
                    timeButton.textContent = time;
                    timeButton.addEventListener('click', () => {
                        showConfirmationModal(selectedDate, time);
                        timeModal.style.display = 'none'; // Close time modal
                    });
                    timeButtonsContainer.appendChild(timeButton);
                });

                timeModal.style.display = 'flex'; // Show the modal
            }

            // Function to show final confirmation modal
            function showConfirmationModal(date, time) {
                const formattedDate = date.toLocaleDateString('pt-BR', {
                    weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
                });

                finalMessage.innerHTML = `Que ótimo! Você sugeriu o encontro para:<br><span class="font-bold pink-text-dark">${formattedDate}</span> às <span class="font-bold pink-text-dark">${time}</span>.<br>Mal posso esperar!`;
                confirmationModal.style.display = 'flex';
            }

            // Close time modal when clicking on 'x'
            closeTimeModalButton.addEventListener('click', () => {
                timeModal.style.display = 'none';
            });

            // Close confirmation modal when clicking on 'x'
            closeConfirmationModalButton.addEventListener('click', () => {
                confirmationModal.style.display = 'none';
            });

            // Close confirmation modal when clicking on 'Ok!'
            okFinalButton.addEventListener('click', () => {
                confirmationModal.style.display = 'none';
            });

            // Close modals when clicking outside of their content
            window.addEventListener('click', (event) => {
                if (event.target === timeModal) {
                    timeModal.style.display = 'none';
                }
                if (event.target === confirmationModal) {
                    confirmationModal.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
