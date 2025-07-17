import { menu } from './menu.js';
const words = 'in one good real one not school set they state high life consider on and not come what also for set point can want as while with of order child about school thing never hold find order each too between program work end you home place around while place problem end begin interest while public or where see time those increase interest be give end think seem small as both another a child same eye you between way do who into again good fact than under very head become real possible some write know however late each that with because that place nation only for each change form consider we would interest with world so order or run more open that large write turn never over open each over change still old take hold need give by consider line only leave while what set up number part form want against great problem can because head so first this here would course become help year first end want both fact public long word down also long for without new turn against the because write seem line interest call not if line thing what work people way may old consider leave hold want life between most place may if go who need fact such program where which end off child down change to from people high during people find to however into small new general it do that could old for last get another hand much eye great no work and with but good there last think can around use like number never since world need what we around part show new come seem while some and since still small these you general which seem will place come order form how about just also they with state late use both early too lead general seem there point take general seem few out like might under if ask while such interest feel word right again how about system such between late want fact up problem stand new say move a lead small however large public out by eye here over so be way use like say people work for since interest so face order school good not most run problem group run she late other problem ... [truncated]';
const words_list = words.split(' ');
const wordsCount = words_list.length;
const gameTime = menu.time * 1000;
window.timer = null;
window.gameStart = null;

function addClass(el, name) {
    el.className += ' ' + name;
}

function removeClass(el, name) {
    el.className = el.className.replace(name, '');
}

function randomWord() {
    const randomIndex = Math.floor(Math.random() * wordsCount);
    return words_list[randomIndex];
}

function formatWord(word) {
    return `<div class="word"><span class="letter">${word.split('').join('</span><span class="letter">')}</span></div>`;
}

function newTest() {
    document.getElementById('words').innerHTML = '';
    for (let i = 0; i < menu.word; i++) {
        document.getElementById('words').innerHTML += formatWord(randomWord());
    }
    addClass(document.querySelector('.word'), 'current');
    addClass(document.querySelector('.letter'), 'current');

    window.timer = null;
    window.gameStart = null;
}

function getWpm() {
    const words = [...document.querySelectorAll('.word')];
    const lastTypedWord = document.querySelector('.word.current');
    const lastTypedWordIndex = words.indexOf(lastTypedWord) + 1;
    const typedWords = words.slice(0, lastTypedWordIndex);
    const correctWords = typedWords.filter(word => {
        const letters = [...word.children];
        const incorrectLetters = letters.filter(letter => letter.className.includes('incorrect'));
        const correctLetters = letters.filter(letter => letter.className.includes('correct'));
        return incorrectLetters.length === 0 && correctLetters.length === letters.length;
    });
    const timePassed = (new Date().getTime() - window.gameStart) / 60000;
    return correctWords.length / timePassed;
}
let isOver = false;
function testOver() {
    isOver = true;
    clearInterval(window.timer);
    addClass(document.getElementById('typer'), 'over');
    addClass(document.getElementById('words'), 'opacity-25')
    const wpm = getWpm();
    document.getElementById('speed-info').innerHTML = `${Math.round(wpm)}` + '';
}

document.getElementById('typer').addEventListener('keyup', event => {
    if(isOver) return;
    const key = event.key;
    const currentWord = document.querySelector('.word.current');
    const currentLetter = document.querySelector('.letter.current');
    const expected = currentLetter?.innerHTML || ' ';
    const isLetter = key.length === 1 && key !== ' ';
    const isSpace = key === ' ';
    const isBackspace = key === 'Backspace';
    const isFirstLetter = currentLetter === currentWord.firstChild;

    if (document.querySelector('#typer.over')) {
        return;
    }

    if (!window.timer && isLetter) {
        window.timer = setInterval(() => {
            if (!window.gameStart) {
                window.gameStart = (new Date()).getTime();
            }
            const currentTime = (new Date()).getTime();
            const msPassed = currentTime - window.gameStart;
            const sPassed = Math.round(msPassed / 1000);
            const sLeft = Math.round((gameTime / 1000) - sPassed);
            if (sLeft === 0) {
                document.getElementById('timer-info').innerHTML = 0 + '';
            }
            if (sLeft <= 0) {
                testOver();
                return;
            }
            document.getElementById('timer-info').innerHTML = sLeft + '';
        }, 1000);
    }

    console.log({ key, expected });

    

    if (isLetter) {
        if (currentLetter) {
            addClass(currentLetter, key === expected ? 'correct' : 'incorrect');
            removeClass(currentLetter, 'current');
            if (currentLetter.nextSibling) {
                addClass(currentLetter.nextSibling, 'current');
            }
        } else {
            const incorrectLetter = document.createElement('span');
            incorrectLetter.innerHTML = key;
            incorrectLetter.className = 'letter incorrect extra';
            currentWord.appendChild(incorrectLetter);
        }
    }

    if (isSpace) {
        if (expected !== ' ') {
            const lettersToInvalidate = [...document.querySelectorAll('.word.current .letter:not(.correct)')];
            lettersToInvalidate.forEach(letter => {
                addClass(letter, 'incorrect');
            })
        }
        removeClass(currentWord, 'current');
        addClass(currentWord.nextSibling, 'current');
        if (currentLetter) {
            removeClass(currentLetter, 'current');
        }
        addClass(currentWord.nextSibling.firstChild, 'current');
    }

    if (isBackspace) {
        if (currentLetter) {
            if (currentLetter && !isFirstLetter) {
                // move back one letter, invalidate letter
                removeClass(currentLetter, 'current');
                addClass(currentLetter.previousSibling, 'current');
                removeClass(currentLetter.previousSibling, 'incorrect');
                removeClass(currentLetter.previousSibling, 'correct');
            }
        } else {
            if (currentWord.lastChild.classList.contains('extra')) {
                currentWord.removeChild(currentWord.lastChild)
            } else if (currentWord.previousSibling) {
                // make prev word current, last letter current
                removeClass(currentWord, 'current');
                addClass(currentWord.previousSibling, 'current');
                const prevWord = currentWord.previousSibling;
                if (prevWord.lastChild) {
                    addClass(prevWord.lastChild, 'current');
                    removeClass(prevWord.lastChild, 'incorrect');
                    removeClass(prevWord.lastChild, 'correct');
                }
            }
        }
    }

    // move cursor
    const nextLetter = document.querySelector('.letter.current')
    const nextWord = document.querySelector('.word.current');
    const cursor = document.getElementById('cursor');
    cursor.style.top = (nextLetter || nextWord).getBoundingClientRect().top + 'px';
    cursor.style.left = (nextLetter || nextWord).getBoundingClientRect()[nextLetter ? 'left' : 'right'] + 'px';
})

function tryAgain() {
    removeClass(document.getElementById('typer'), 'over');
    removeClass(document.getElementById('words'), 'opacity-25');
    newTest();
}

newTest();