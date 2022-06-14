;;;Author: Zihe Ye
;;;Project: Laptop select expert system (Project3 of CAP4621 Intro to AI)
;;;description: this expert system has a three big classes cluster, each cluster has four types of laptops. The system gives user a recommendation on laptop based on their input.
;;;Date: 03/20/2021
;;;How to run the program: load the file to clips ide, type (reset), then type(run). The questions will follow up.
;;;Please only input integer for budget, size, weight questions; make sure only input n or y for all other questions.
;;;There are totally 4 classes, 1 instance of each class, 13 rules without counting the input rule, 3 intermediate conclusion for different class instance.
;;;There are 2 functions for asking questions, 1 rule for exception handling telling the user there is no answer inside our system found
;;;We also implemented early stop by call halt after find an answer

;Classes
(defclass LAPTOP ; CLASS#1 LAPTOP class, there is no instance for this class.
	(is-a USER) ; inherits the USER defined class, by default a class is concrete
	(slot budget) ; all following fields are general features of all laptops
	(slot screen_size)
	(slot weight)
	(slot num_pa)
	(slot type_c))
	
(defclass GAMING ; CLASS#2 GAMING laptop class, this class has an extra gpu field for gaming usage
	(is-a USER) ; inherits the USER defined class, by default a class is concrete
	(slot budget) ; all following fields are general features of all laptops
	(slot screen_size)
	(slot weight)
	(slot num_pa)
	(slot type_c)
	(slot gpu)) ; this gpu field is the extra field for GAMING laptop, default set to n for later comparison
	
(defclass ARTISTIC ; CLASS#3 ARTISTIC laptop class, this class has extra touch_screen field for painting usage
	(is-a USER) ; inherits the USER defined class, by default a class is concrete
	(slot budget) ; all following fields are general features of all laptops
	(slot screen_size)
	(slot weight)
	(slot num_pa)
	(slot type_c)
	(slot touch_screen)) ; this touch_screen field is the extra field for ARTISTIC laptop, default set to n for later comparison

(defclass BUSINESS ; CLASS#4 BUSINESS laptop class, this class has extra thunder_bolt field for business presentation usage
	(is-a USER) ; inherits the USER defined class, by default a class is concrete
	(slot budget) ; all following fields are general features of all laptops
	(slot screen_size)
	(slot weight)
	(slot num_pa)
	(slot type_c)
	(slot thunder_bolt)) ; this thunder_bolt field is the extra field for BUSINESS laptop, default set to n for later comparison


;Ask Functions
(deffunction ask-question (?question $?allowed-values) ; this is the function for asking yes or no question
   (printout t ?question)  ; print the question and prompt
   (bind ?answer (read)) ; assign the value read from the command line to symbol answer
   (if (lexemep ?answer) ; enforce the value user inputs is a string
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do  ; while loop to make sure the input is string
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))  ; convert the input to lowercase
   ?answer)

(deffunction ask-question-new (?question) ; this is the function for asking value question, answer needs to be integer
   (printout t ?question) ; print the question and prompt
   (bind ?answer (read)) ; assign the value read from the command line to symbol answer
   (if (integerp ?answer) ; enforce the value user inputs is an integer
       then)
   (while (not (integerp ?answer)) do  ; while loop to make sure the input is integer
      (printout t ?question)
      (bind ?answer (read))
      (if (integerp ?answer) 
          then))
   ?answer)


; Rules
; All following parts till the instances part are rules starting by defrule
(defrule placevalueinobject  ; the beginning rule for asking input
	?ins <- (object (is-a LAPTOP))  ; this is the LAPTOP instance for helping later instances
	?ins1 <- (object (is-a GAMING))  ; this is the GAMING instance to store extra gpu field
	?ins2 <- (object (is-a ARTISTIC))  ; this is the ARTISTIC instance to store extra touch_screen field
	?ins3 <- (object (is-a BUSINESS))  ; this is the BUSINESS instance to store extra thunder_bolt field
	=> 
	(send ?ins put-budget (ask-question-new "What is your budget?"))  ; the ask-question function returns the answer and will be assigned to the according field by calling put-attr
	(send ?ins put-screen_size (ask-question-new "What is your screen_size?"))
	(send ?ins put-weight (ask-question-new "What is your max laptop weight?"))
	(send ?ins put-num_pa (ask-question "Does your laptop have a numpad or not? y/n" y n))
	(send ?ins put-type_c (ask-question "Does your laptop have a typec or not? y/n" y n))
	(send ?ins1 put-gpu (ask-question "Does your laptop have a gpu or not? y/n" y n))
	(send ?ins2 put-touch_screen (ask-question "Does your laptop have a touch_screen or not? y/n" y n))
	(send ?ins3 put-thunder_bolt (ask-question "Does your laptop have a thunder_bolt or not? y/n" y n))
	(send ?ins1 put-budget (send ?ins get-budget)) ; read the value from the LAPTOP instance and copy to other instances for general usage
	(send ?ins1 put-screen_size (send ?ins get-screen_size))
	(send ?ins1 put-weight (send ?ins get-weight))
	(send ?ins1 put-num_pa (send ?ins get-num_pa))
	(send ?ins1 put-type_c (send ?ins get-type_c))
	(send ?ins2 put-budget (send ?ins get-budget))
	(send ?ins2 put-screen_size (send ?ins get-screen_size))
	(send ?ins2 put-weight (send ?ins get-weight))
	(send ?ins2 put-num_pa (send ?ins get-num_pa))
	(send ?ins2 put-type_c (send ?ins get-type_c))
	(send ?ins3 put-budget (send ?ins get-budget))
	(send ?ins3 put-screen_size (send ?ins get-screen_size))
	(send ?ins3 put-weight (send ?ins get-weight))
	(send ?ins3 put-num_pa (send ?ins get-num_pa))
	(send ?ins3 put-type_c (send ?ins get-type_c))
)

(defrule alienware_m15_r3  ; rule#1, intermediate conclusion#1. Gaming laptop
    ?ins <- (object (is-a GAMING) (budget ?mn) (screen_size ?pq) (num_pa ?oi) (type_c ?uo) (gpu ?yp))
    (test (and (>= ?mn 1450) (= ?pq 15) (eq ?oi n) (eq ?uo n) (eq ?yp y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Alienware m15 R3 is the gaming laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule alienware_m17_r3 ; rule#2, intermediate conclusion#1. Gaming laptop
    ?ins <- (object (is-a GAMING) (budget ?mn) (screen_size ?pq) (num_pa ?oi) (type_c ?uo) (gpu ?yp))
    (test (and (>= ?mn 1450) (= ?pq 17) (eq ?oi y) (eq ?uo n) (eq ?yp y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Alienware m17 R3 is the gaming laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule Omen ; rule#3, intermediate conclusion#1. Gaming laptop
    ?ins <- (object (is-a GAMING) (budget ?mn) (screen_size ?pq) (num_pa ?oi) (type_c ?uo) (gpu ?yp))
    (test (and (>= ?mn 1240) (= ?pq 15) (eq ?oi n) (eq ?uo y) (eq ?yp y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Omen is the gaming laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule dell_g3_15 ; rule#4, intermediate conclusion#1. Gaming laptop
    ?ins <- (object (is-a GAMING) (budget ?mn) (screen_size ?pq) (num_pa ?oi) (type_c ?uo) (gpu ?yp))
    (test (and (>= ?mn 810) (= ?pq 15) (eq ?oi y) (eq ?uo y) (eq ?yp y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Dell G3 15 is the gaming laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule surface_laptop_3 ; rule#5, intermediate conclusion#2. ARTISTIC LAPTOP
    ?ins <- (object (is-a ARTISTIC) (budget ?mn) (screen_size ?pq) (weight ?oi) (num_pa ?np) (type_c ?uo) (touch_screen ?ts) )
    (test (and (>= ?mn 1700) (= ?pq 13) (>= ?oi 2.79) (eq ?np y) (eq ?uo y) (eq ?ts y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Surface laptop 3 is the artistic laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule spectre_folio ; rule#6, intermediate conclusion#2. ARTISTIC LAPTOP
    ?ins <- (object (is-a ARTISTIC) (budget ?mn) (screen_size ?pq) (touch_screen ?ts) (num_pa ?np) (weight ?oi) (type_c ?uo))
    (test (and (>= ?mn 1400) (= ?pq 13) (eq ?ts y) (eq ?np n) (>= ?oi 3.24) (eq ?uo n)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Surface laptop 3 is the artistic laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule hp_envy_15_touch ; rule#7, intermediate conclusion#2. ARTISTIC LAPTOP
    ?ins <- (object (is-a ARTISTIC) (budget ?mn) (screen_size ?pq) (touch_screen ?ts) (num_pa ?np) (weight ?oi) (type_c ?uo))
    (test (and (>= ?mn 1300) (= ?pq 15) (eq ?ts y) (eq ?np n) (>= ?oi 4.74) (eq ?uo y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "HP envy 15 touch is the artistic laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule surface_pro_7  ; rule#8, intermediate conclusion#2. ARTISTIC LAPTOP
    ?ins <- (object (is-a ARTISTIC) (budget ?mn) (screen_size ?pq) (touch_screen ?ts) (num_pa ?np) (weight ?oi) (type_c ?uo))
    (test (and (>= ?mn 750) (= ?pq 13) (eq ?ts y) (eq ?np n) (>= ?oi 1.70) (eq ?uo y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Surface pro 7 is the artistic laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule hp_elite_dragonfly  ; rule#9, intermediate conclusion#3. BUSINESS LAPTOP
    ?ins <- (object (is-a BUSINESS) (budget ?mn) (screen_size ?pq) (weight ?oi) (num_pa ?np) (type_c ?uo) (thunder_bolt ?tb))
    (test (and (>= ?mn 2300) (= ?pq 13) (>= ?oi 2.2) (eq ?np n) (eq ?uo n) (eq ?tb y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "HP elite dragonfly is the business laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule spectre_x360_15  ; rule#10, intermediate conclusion#3. BUSINESS LAPTOP
    ?ins <- (object (is-a BUSINESS) (budget ?mn) (screen_size ?pq) (weight ?oi) (num_pa ?np) (type_c ?uo) (thunder_bolt ?tb))
    (test (and (>= ?mn 1600) (= ?pq 15) (>= ?oi 4.23) (eq ?np y) (eq ?uo n) (eq ?tb y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Spectre x360 15 is the business laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule xps_15  ; rule#11, intermediate conclusion#3. BUSINESS LAPTOP
    ?ins <- (object (is-a BUSINESS) (budget ?mn) (screen_size ?pq) (weight ?oi) (num_pa ?np) (type_c ?uo) (thunder_bolt ?tb))
    (test (and (>= ?mn 1400) (= ?pq 15) (>= ?oi 4) (eq ?np n) (eq ?uo n) (eq ?tb y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "XPS 15 is the business laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)

(defrule pavillion_15  ; rule#12, intermediate conclusion#3. BUSINESS LAPTOP
    ?ins <- (object (is-a BUSINESS) (budget ?mn) (screen_size ?pq) (weight ?oi) (num_pa ?np) (type_c ?uo) (thunder_bolt ?tb))
    (test (and (>= ?mn 610) (= ?pq 15) (>= ?oi 3.86) (eq ?np y) (eq ?uo y) (eq ?tb y)))  ; using test comparison to test if the laptop matches user's requirement
    =>
    (printout t "Pavillion 15 is the business laptop we recommend!" crlf)  ;  printout the correct recommendation
	(halt)  ; early stop
)


;default for errors and no matches
(defrule default (declare (salience -50)) ; rule#13, exception handling rule
	(test (eq 1 1))  ; using test comparison to test if the laptop matches user's requirement
	=>
	(printout t "No laptop matches your configuration!" crlf)  ; Exception handling, no matched instance recommended
)


;instances
(definstances a  ; instance#1, class of LAPTOP
	(a of LAPTOP(budget 1)(screen_size 1)(weight 1)(num_pa y)(type_c y))
)
(definstances b  ; instance#2, class of GAMING
	(b of GAMING(budget 1)(screen_size 1)(weight 1)(num_pa y)(type_c y)(gpu n))
)
(definstances c  ; instance#3, class of ARTISTIC
	(c of ARTISTIC(budget 1)(screen_size 1)(weight 1)(num_pa y)(type_c y)(touch_screen n))
)
(definstances d  ; instance#4, class of BUSINESS
	(d of BUSINESS(budget 1)(screen_size 1)(weight 1)(num_pa y)(type_c y)(thunder_bolt n))
)