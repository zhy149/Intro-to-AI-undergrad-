/* laptop.pro
  laptop identification game.  
  author: Zihe Ye
  program purpose: Ask user for requirement and give them 
  suggestion on selecting laptops
  command to input: when asked about Budget, weight and Size, please input numbers,
  when asked about other questions, please input yes or no. All answers should
  be ended with '.'
    start with ?- go.     */

go :- write('What\'s your max budget? Unit: $USD '),
	  nl,
	  read(Budget),
	  nl,
	  write('What\'s your max weight requirement for the laptop? Unit: lb'),
	  nl,
	  read(Weight),
	  nl,
	  write('How large do you want your laptop screen size to be? Please input 13, 15, 16, or 17'),
	  nl,
	  read(Size),
	  nl,
	  write('Does your laptop have touch screen? Enter "yes" or "no"'),
	  nl,
	  read(Screen),
	  nl,
	  write('Does your laptop have thunderbolt? Enter "yes" or "no"'),
	  nl,
	  read(Bolt),
	  nl,
	  write('Does your laptop have a numpad? Enter "yes" or "no"'),
	  nl,
	  read(Pad),
	  nl,
	  write('Does your laptop have a type-c port? Enter "yes" or "no"'),
	  nl,
	  read(Type),
	  nl,
	  hypothesize(Laptop, Budget, Weight, Size, Screen, Bolt, Pad, Type),
      write('The following laptop fits you best: '),
      write(Laptop),
      nl,
      undo.


/* hypotheses to be tested */
hypothesize(mac_pro_16, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				mac_pro_16(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Elite_Dragonfly, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Elite_Dragonfly(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(surface_Laptop_3, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				surface_Laptop_3(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Spectre_x360_15, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Spectre_x360_15(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(alien_R3_m15, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				alien_R3_m15(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(alien_R3_m17, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				alien_R3_m17(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_Xps_15, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_Xps_15(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_Xps_17, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_Xps_17(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Spectre_folio_13, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Spectre_folio_13(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(surface_Book_3, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				surface_Book_3(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Envy_15_Touch, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Envy_15_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Envy_17_Touch, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Envy_17_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(mac_pro_13, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				mac_pro_13(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Omen, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Omen(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_Xps_13, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_Xps_13(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_15_G7, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_15_G7(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(mac_air, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				mac_air(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_15_G3, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_15_G3(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_15_G5, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_15_G5(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(surface_Pro_7, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				surface_Pro_7(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Envy_13_Touch, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Envy_13_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Pavilion_15, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Pavilion_15(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(hp_Pavilion_Gaming, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				hp_Pavilion_Gaming(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_inspiron_3000, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_inspiron_3000(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(dell_inspiron_5000, Budget, Weight, Size, Screen, Bolt, Pad, Type):- 
				dell_inspiron_5000(Budget, Weight, Size, Screen, Bolt, Pad, Type), !.
hypothesize(unknown, _, _, _, _, _, _, _):- 1==1.            /* no diagnosis */


mac_air(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1000,
				Weight >= 2.8,
				Size == 13,
				type2(Screen, Bolt, Pad), 
				Type == 'no',
				(verify(home);verify(work)).
mac_pro_13(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1300,
				Weight >= 3.0,
				Size == 13,
				type2(Screen, Bolt, Pad), 
				Type == 'no',
				(verify(home);verify(work)).
mac_pro_16(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 2400,
				Weight >= 4.3,
				Size == 16,
				type2(Screen, Bolt, Pad), 
				Type == 'yes',
				(verify(home);verify(work)).
dell_inspiron_3000(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 300,
				Weight >= 4.83,
				Size == 15,
				type1(Screen, Bolt, Pad), 
				Type == 'no',
				verify(home).
dell_inspiron_5000(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 480,
				Weight >= 3.78,
				Size == 15,
				type1(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(home).
dell_Xps_13(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1100,
				Weight >= 2.64,
				Size == 13,
				type2(Screen, Bolt, Pad), 
				Type == 'no',
				verify(work).
dell_Xps_15(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1400,
				Weight >= 4.0,
				Size == 15,
				type2(Screen, Bolt, Pad), 
				Type == 'no',
				verify(work).
dell_Xps_17(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1400,
				Weight >= 4.65,
				Size == 17,
				type2(Screen, Bolt, Pad), 
				Type == 'no',
				verify(work).
alien_R3_m15(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1450,
				Weight >= 4.65,
				Size == 15,
				Screen == 'no',
				Pad == 'no',
				Bolt == 'no',
				Type == 'no',
				verify(game).
alien_R3_m17(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1450,
				Weight >= 5.51,
				Size == 17,
				type1(Screen, Bolt, Pad), 
				Type == 'no',
				verify(game).
dell_15_G3(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 810,
				Weight >= 5.18,
				Size == 15,
				type3(Screen, Bolt, Pad), 
				Type == 'no',
				verify(game).
dell_15_G5(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 800,
				Weight >= 5.18,
				Size == 15,
				type3(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(game).
dell_15_G7(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1100,
				Weight >= 4.98,
				Size == 15,
				type2(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(game).
hp_Envy_13_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 730,
				Weight >= 2.59,
				Size == 13,
				type4(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(home).
hp_Envy_15_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1300,
				Weight >= 4.74,
				Size == 15,
				type4(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(home).
hp_Envy_17_Touch(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1300,
				Weight >= 6.14,
				Size == 17,
				Screen == 'yes',
				Pad == 'yes',
				Bolt == 'no',
				Type == 'yes',
				verify(home).
hp_Spectre_x360_15(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1600,
				Weight >= 4.23,
				Size == 15,
				type3(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(work).
hp_Spectre_folio_13(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1400,
				Weight >= 3.24,
				Size == 13,
				Screen == 'yes',
				Pad == 'no',
				Bolt == 'yes',
				Type == 'yes',
				verify(work).
hp_Elite_Dragonfly(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 2300,
				Weight >= 2.2,
				Size == 13,
				type2(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(work).
hp_Pavilion_15(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 610,
				Weight >= 3.86,
				Size == 15,
				type1(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(home).
hp_Pavilion_Gaming(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 700,
				Weight >= 4.92,
				Size == 15,
				type1(Screen, Bolt, Pad), 
				Type == 'yes',
				verify(game).
hp_Omen(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1240,
				Weight >= 5.2,
				Size == 15,
				Screen == 'no',
				Pad == 'no',
				Bolt == 'yes',
				Type == 'yes',
				verify(game).
surface_Laptop_3(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1700,
				Weight >= 2.79,
				Size == 13,
				type4(Screen, Bolt, Pad), 
				Type == 'yes',
				(verify(home);verify(work)).
surface_Pro_7(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 750,
				Weight >= 1.7,
				Size == 13,
				type4(Screen, Bolt, Pad), 
				Type == 'no',
				(verify(home);verify(work)).
surface_Book_3(Budget, Weight, Size, Screen, Bolt, Pad, Type) :- 
				Budget >= 1400,
				Weight >= 3.38,
				Size == 15,
				type4(Screen, Bolt, Pad), 
				Type == 'yes',
				(verify(home);verify(work)).


:- dynamic(type1/0).


/* classification rules */			
type1(Screen, Bolt, Pad) :- Screen == 'no',
							Pad == 'yes',
							Bolt == 'no'.
type2(Screen, Bolt, Pad) :- Screen == 'no',
							Pad == 'no',
							Bolt == 'yes'.
type3(Screen, Bolt, Pad) :- Screen == 'yes',
							Pad == 'yes',
							Bolt == 'yes'.
type4(Screen, Bolt, Pad) :- Screen == 'yes',
							Pad == 'no',
							Bolt == 'no'.


/* how to ask questions */
:- dynamic(geq_than/2).
geq_than(Input1, Input2) :- Input1 >= Input2.  /*a is greater equal to b*/
:- dynamic(eq_to/2).
eq_to(Input1, Input2) :- Input1==Input2.


:- dynamic(yes/1,no/1).


ask(Question) :-
    write('Do you need the following function? '),
	nl,
    write(Question),
	nl,
    read(Response),
    nl, 
    ((Response == 'yes';Response == 'y')
      ->
       asserta(yes(Question));
       asserta(no(Question)), fail).


verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).


undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.