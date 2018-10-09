(clear)
(reset)
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)

; These are the global fuzzy variables

(defglobal ?*meal* = (new nrc.fuzzy.FuzzyVariable "meal" 0.0 10.0 "Type of Meal"))
(defglobal ?*proteins* = (new nrc.fuzzy.FuzzyVariable "proteins" 0.0 300 "Grams"))
(defglobal ?*carbs* = (new nrc.fuzzy.FuzzyVariable "carbs" 0.0 600 "Grams"))
(defglobal ?*fats* = (new nrc.fuzzy.FuzzyVariable "fats" 0.0 200 "Grams"))

(defglobal ?*proveg* = (new nrc.fuzzy.FuzzyVariable "opt1" 1.0 5.0 ""))
(defglobal ?*prononveg* = (new nrc.fuzzy.FuzzyVariable "opt2" 1.0 5.0 ""))


(defglobal ?*carbsveg* = (new nrc.fuzzy.FuzzyVariable "opt3" 1.0 5.0 ""))
(defglobal ?*carbsnonveg* = (new nrc.fuzzy.FuzzyVariable "opt4" 1.0 5.0 ""))


(defglobal ?*fatsveg* = (new nrc.fuzzy.FuzzyVariable "opt5" 1.0 5.0 ""))
(defglobal ?*fatsnonveg* = (new nrc.fuzzy.FuzzyVariable "opt6" 1.0 5.0 ""))


(defglobal ?*lowallveg* = (new nrc.fuzzy.FuzzyVariable "opt7" 1.0 5.0 ""))
(defglobal ?*highallveg* = (new nrc.fuzzy.FuzzyVariable "opt8" 1.0 5.0 ""))


(defglobal ?*lowallnonveg* = (new nrc.fuzzy.FuzzyVariable "opt9" 1.0 5.0 ""))
(defglobal ?*highallnonveg* = (new nrc.fuzzy.FuzzyVariable "opt10" 1.0 5.0 ""))



; This is the initial rule that initializes the different possibilities of each
; fuzzy variable

(defrule startup
    =>
    (load-package nrc.fuzzy.jess.FuzzyFunctions) 
    (?*meal* addTerm "veg" (create$ 0.0 5.0) (create$ 1.0 0.0) 2)
    (?*meal* addTerm "nonveg" (create$ 5.0 10.0) (create$ 0.0 1.0) 2)
    (?*proteins* addTerm "low" (create$ 0.0 100.0) (create$ 1.0 0.0) 2)
    (?*proteins* addTerm "high" (create$ 100.0 300.0) (create$ 0.0 1.0) 2)
    (?*carbs* addTerm "low" (create$ 0.0 300) (create$ 1.0 0.0) 2)
    (?*carbs* addTerm "high" (create$ 300 600) (create$ 0.0 1.0) 2)
    (?*fats* addTerm "low" (create$ 0.0 80) (create$ 1.0 0.0) 2)
    (?*fats* addTerm "high" (create$ 80 200) (create$ 0.0 1.0) 2)
    
    (?*carbsveg* addTerm "lowcarb" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*carbsveg* addTerm "highcarb" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*carbsnonveg* addTerm "lowcarb" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*carbsnonveg* addTerm "highcarb" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*proveg* addTerm "lowprotein" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*proveg* addTerm "highprotein" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*prononveg* addTerm "lowprotein" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*prononveg* addTerm "highprotein" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*fatsveg* addTerm "lowfat" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatsveg* addTerm "highfat" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*fatsnonveg* addTerm "lowfat" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatsnonveg* addTerm "highfat" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*lowallveg* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallveg* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*lowallnonveg* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallnonveg* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (assert (initDone))
    )

; Once the fuzzy variables are initialized, the user is prompted for input using this rule
; Then based on user input, this rule creates necessary facts for recommendation

(defrule ask_user
    (initDone)
    =>
  (printout t " " crlf)
  (printout t " " crlf)
  (printout t "WELCOME TO GROCERY SHOPPING EXPERT!. I am here to help you!" crlf)
  (printout t "Please type your name and press Enter> ")
  (bind ?name (readline))
  (printout t crlf "##################################################" crlf)
    (printout t "Hello, " ?name "." crlf)
    (printout t " " crlf)
  
    (printout t "Please answer the following questions and we will tell you groceries to buy." crlf)
    (printout t crlf)
    (printout t "What type of food would you like to have?( veg or nonveg):" crlf)
	(bind ?ml (readline))
    (printout t "Do you want to have a low/high protein grocery?( low or high):" crlf)
    (bind ?pt (readline))
    (printout t "Do you want to have a low/high carbohydrate grocery?( low or high):" crlf)
    (bind ?cb (readline))
    (printout t "Do you want to have a low/high fats grocery?( low or high):" crlf)
    (bind ?ft (readline))
    
	(assert (meal (new nrc.fuzzy.FuzzyValue ?*meal* ?ml)))
    (assert (proteins (new nrc.fuzzy.FuzzyValue ?*proteins* ?pt)))
    (assert (carbs (new nrc.fuzzy.FuzzyValue ?*carbs* ?cb)))
    (assert (fats (new nrc.fuzzy.FuzzyValue ?*fats* ?ft))))
;  rule are combination of proteins, Carbohydrates, fats , type of meal and diet.


; Rule 1
(defrule Veg_Low_All_gain
    
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt7 (new nrc.fuzzy.FuzzyValue ?*lowallveg* "lowall")))
    )


; Rule 2
(defrule Veg_high_pro_gain
	
   (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt1 (new nrc.fuzzy.FuzzyValue ?*proveg* "highprotein")))
    )

; Rule 3
(defrule Veg_high_carb_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt3 (new nrc.fuzzy.FuzzyValue ?*carbsveg* "highcarb")))
    )


; Rule 4
(defrule Veg_high_fat_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt5 (new nrc.fuzzy.FuzzyValue ?*fatsveg* "highfat")))
    )


; Rule 5
(defrule Veg_low_fat_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt5 (new nrc.fuzzy.FuzzyValue ?*fatsveg* "lowfat")))
    )


; Rule 6
(defrule Veg_low_carb_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt3 (new nrc.fuzzy.FuzzyValue ?*carbsveg* "lowcarb")))
    )


; Rule 7
(defrule Veg_low_pro_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt1 (new nrc.fuzzy.FuzzyValue ?*proveg* "lowprotein")))
    )


; Rule 8
(defrule Veg_All_high_gain
	
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt8 (new nrc.fuzzy.FuzzyValue ?*highallveg* "highall")))
    )

; Rule 9
(defrule Nonveg_All_low_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt9 (new nrc.fuzzy.FuzzyValue ?*lowallnonveg* "lowall")))
    )


; Rule 10
(defrule Nonveg_high_pro_gain
	
   (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt2 (new nrc.fuzzy.FuzzyValue ?*prononveg* "highprotein")))
    )


; Rule 11
(defrule Nonveg_high_carb_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt4 (new nrc.fuzzy.FuzzyValue ?*carbsnonveg* "highcarb")))
    )

; Rule 12
(defrule Nonveg_high_fat_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt6 (new nrc.fuzzy.FuzzyValue ?*fatsnonveg* "highfat")))
    )

; Rule 13
(defrule Nonveg_low_fat_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt6 (new nrc.fuzzy.FuzzyValue ?*fatsnonveg* "lowfat")))
    )


; Rule 14
(defrule Nonveg_low_carbs_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt4 (new nrc.fuzzy.FuzzyValue ?*carbsnonveg* "lowcarb")))
    )


; Rule 15
(defrule Nonveg_low_pro_gain
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt2 (new nrc.fuzzy.FuzzyValue ?*prononveg* "lowprotein")))
    )


; Rule 16

(defrule Nonveg_high_all_gain
	
	
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt10 (new nrc.fuzzy.FuzzyValue ?*highallnonveg* "highall")))
    )


(defrule Food_suggest1
    (opt7 ?i&:(fuzzy-match ?i "lowall"))
    =>
	
    (printout t "You can buy whole grain bread,nuts and nut butter,milk and rice." crlf))


(defrule Food_suggest2
    (opt1 ?i&:(fuzzy-match ?i "highprotein"))
    =>
    (printout t "You can buy spinach,sundried tomatoes,guava,artichokes and peas" )
	
)

	

(defrule Food_suggest3
    (opt3 ?j&:(fuzzy-match ?j "highcarb"))
    =>
   (printout t "You can buy dry fruits,Pasta,corn,potatoes and bread." crlf))


 
    
(defrule Food_suggest4
    (opt5 ?k&:(fuzzy-match ?k "highfat"))
    =>
    (printout t "You can buy fast foods,fried food,deserts and dark choclate." crlf))


(defrule Food_suggest5
    (opt5 ?ll&:(fuzzy-match ?ll "lowfat"))
    =>
    (printout t "You can buy flaxseed,avacado,cinamon,green tea,lentils and bananas." crlf))



(defrule Food_suggest6
    (opt3 ?ll&:(fuzzy-match ?ll "lowcarb"))
    => (printout t "You can cauliflower,cabbage,broccoli,green beans and kale." crlf))

    
(defrule Food_suggest7
    (opt1 ?ll&:(fuzzy-match ?ll "lowprotein"))
    =>
     (printout t "You can buy pineapple,apple,mayonnaise,rice,green beans." crlf))


(defrule Food_suggest8
    (opt8 ?i&:(fuzzy-match ?i "highall"))
    =>
     (printout t "You can buy Brown rice,yams,multigrain cereal and butternut squash." crlf))
	 


(defrule Food_suggest9
    (opt9 ?i&:(fuzzy-match ?i "lowall"))
    =>
    (printout t "You can buy beef,Salmon, trout, haddock ." crlf))


(defrule Food_suggest10
    (opt2 ?i&:(fuzzy-match ?i "highprotein"))
    =>
    (printout t "You can buy egg, chicken breast and turkey meat." crlf))



(defrule Food_suggest11
    (opt4 ?j&:(fuzzy-match ?j "highcarb"))
    =>
   (printout t "You can buy Beef, lamb, pork." crlf))
   

    
(defrule Food_suggest12
    (opt6 ?k&:(fuzzy-match ?k "highfat"))
    =>
    (printout t "You can buy lamb,lard,fried chicken" crlf))
	


(defrule Food_suggest13
    (opt6 ?ll&:(fuzzy-match ?ll "lowfat"))
    =>
    (printout t "You can buy skinless poultry,beef cuts,pork and lamb." crlf))
	


(defrule Food_suggest14
    (opt4 ?ll&:(fuzzy-match ?ll "lowcarb"))
    => (printout t "You can buy turkey meat,veal,haddock and halibut." crlf))
	

	
    
(defrule Food_suggest15
    (opt2 ?ll&:(fuzzy-match ?ll "lowprotein"))
    =>
     (printout t "You can buy lean beef,pork and lamb." crlf))
	 


(defrule Food_suggest16
    (opt10 ?i&:(fuzzy-match ?i "highall"))
    =>
     (printout t "You can buy chicken breast,shrimp,turkey breast." crlf))


(run)