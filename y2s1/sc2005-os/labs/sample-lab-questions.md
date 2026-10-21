These questions are taken from past lab quizzes, which followed a different syllabus. Reference this only for the general format of questions that may be tested. There is not guarantee that any of these format of questions may appear though.

# Lab Quiz 1

*(Most are straightforward)*

- What is false about NachOS?
  It directly runs on hardware.
- What is false about `Schedule()`?
  List is sorted in descending order.
- What does the `join` in `fork()` argument do?
  True, the parent calls and waits for the child process; a flag which indicates whether the thread can be joined.
- What does `FindNextToRun()` do?
  The thread simply returns the thread at the front of the ready list.
- What does `Run()` do?
  Switches from one thread to another.
- What does `TimeOfNextInterrupt()` do?
  The function returns the next interrupt time click.
- What best describes the NachOS scheduling policy?
  I put "none of the above" because NachOS is FCFS.
- What is the output of the following code in CSV?
  Look at the Lab 1 CSV and how you can copy and paste it.
- In the `initialise()` … _[text obscured in screenshot]_
  Yes, randomYield set to True.
- What is the state when `Thread()` is used?
  Just created.

## Other People's Question Bank

1. What's the time quantum for this code?
2. What's the function to edit to make round robin?
   TimeOfNextInterrupt()
3. Does this code show that the interrupt timer is implemented?
   randomYield = true
4. Data structure to implement the ready list?
   Queue
5. What thread is in the running state at this tick?
6. What is the output of this code?
   Lab 1 threadtest

---

### Q1. Steps to switching thread

Ans: 4 steps found in slides under Run(thread):

- [ ] Check whether the current thread overflowed its stack.
- [ ] Change the state of the new thread to running.
- [ ] Perform the actual context switch (by calling Switch()).
- [ ] Terminate the previous thread (if applicable).

### Q2. The function FindNextToRun() simply returns the thread at the front of the ready list. True or false?

Ans: True

### Q3. What is false about NachOS?

Ans: NachOS runs directly on hardware.

### Q4. What is the status of the thread after Thread()?

Ans: JUST_CREATED

### Q5. If yieldOnReturn is true, the function triggers a context switch through a call to Thread::Yield(). True or false?

Ans: True

---

### 1. Which of the following allows you to add a new interrupt to the pending list? *(More than one option question)*

- Schedule()
- OneTick()
- Yield()
- None of the options

### 2. What state is a thread put in when it is removed from the waiting state (for example, after acquiring a lock)?

- READY
- RUNNING
- WAITING
- *(something I forgot)*