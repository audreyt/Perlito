;; Do not edit this file - Generated by MiniPerl6 3.0
;; class Test
(defpackage mp-Test
  (:use common-lisp mp-Main))
;; (in-package mp-Test)
(let ((sv-num_of_tests_run (sv-undef))(sv-num_of_tests_failed (sv-undef))(sv-num_of_tests_badpass (sv-undef))(sv-num_of_tests_planned (sv-undef))(sv-testing_started (sv-undef)))
(if (not (ignore-errors (find-class 'mp-Test)))
  (defclass mp-Test () ()))

(let (x) 
  (setq x (make-instance 'mp-Test))
  (defun proto-mp-Test () x))
(in-package mp-Test)
  (defun sv-plan (&optional sv-number_of_tests )
  (block mp6-function (progn (setf sv-testing_started 1)(setf sv-num_of_tests_planned sv-number_of_tests)(mp-Main::sv-say (list (concatenate 'string (sv-string "1..") (sv-string sv-number_of_tests)))))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-ok (&optional sv-cond sv-desc sv-todo sv-depends )
  (block mp6-function (progn (mp-Test::sv-proclaim sv-cond (concatenate 'string (sv-string "ok! ") (sv-string sv-desc)) sv-todo sv-depends))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-is (&optional sv-got sv-expected sv-desc sv-todo sv-depends )
  (block mp6-function (let ((sv-test (sv-undef))) (setf sv-test (sv-eq sv-got sv-expected))(mp-Test::sv-proclaim sv-test (concatenate 'string (sv-string "is! ") (sv-string sv-desc)) sv-todo sv-got sv-expected sv-depends))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-is_deeply (&optional sv-got sv-expected sv-desc sv-todo sv-depends )
  (block mp6-function (let ((sv-got_perl (sv-undef))(sv-expected_perl (sv-undef))(sv-test (sv-undef))) (setf sv-got_perl (sv-perl sv-got ))(setf sv-expected_perl (sv-perl sv-expected ))(setf sv-test (sv-eq sv-got_perl sv-expected_perl))(mp-Test::sv-proclaim sv-test (concatenate 'string (sv-string "is deeply! ") (sv-string sv-desc)) sv-todo sv-got_perl sv-expected_perl sv-depends))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-isnt (&optional sv-got sv-expected sv-desc sv-todo sv-depends )
  (block mp6-function (let ((sv-test (sv-undef))) (setf sv-test (not (sv-bool (sv-eq sv-got sv-expected))))(mp-Test::sv-proclaim sv-test (concatenate 'string (sv-string "isnt! ") (sv-string sv-desc)) sv-todo sv-got sv-expected sv-depends (let ((h (make-hash-table :test 'equal))) (setf (mp-Main::sv-hash-lookup "negate" h) 1) h)))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-cmp_ok (&optional sv-got sv-compare_func sv-expected sv-desc sv-todo sv-depends )
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::cmp_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-like ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::like not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-unlike ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::unlike not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-eval_dies_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::eval_dies_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-isa_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::isa_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-use_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::use_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-throws_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::throws_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-dies_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::dies_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-lives_ok ()
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::lives_ok not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-skip (&optional sv-reason sv-depends )
  (block mp6-function (progn (mp-Test::sv-proclaim 1 "" (concatenate 'string (sv-string "skip ") (sv-string sv-reason)) sv-depends))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-pass (&optional sv-desc )
  (block mp6-function (progn (mp-Test::sv-proclaim 1 (concatenate 'string (sv-string "pass! ") (sv-string sv-desc))))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-flunk (&optional sv-desc sv-todo sv-depends )
  (block mp6-function (progn (mp-Test::sv-proclaim 0 (concatenate 'string (sv-string "flunk! ") (sv-string sv-desc)) sv-todo sv-depends))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-proclaim (&optional sv-cond sv-desc sv-todo sv-got sv-expected sv-depends sv-negate )
  (block mp6-function (progn (setf sv-testing_started 1)(setf sv-num_of_tests_run (+ sv-num_of_tests_run 1))(if (sv-bool sv-cond) (progn (mp-Main::sv-say (list "ok " sv-num_of_tests_run))) (progn (mp-Main::sv-say (list "not ok " sv-num_of_tests_run))(mp-Test::sv-report_failure sv-todo sv-got sv-expected sv-negate)))(return-from mp6-function sv-cond))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-report_failure (&optional sv-todo sv-got sv-expected sv-negate )
  (block mp6-function (progn (mp-Main::sv-say (list "### Test::report_failure not implemented")))))

(in-package mp-Main)
(in-package mp-Test)
  (defun sv-test_ends ()
  (block mp6-function (progn (if (sv-bool (not (sv-bool sv-testing_started))) (progn (return-from mp6-function (sv-undef))) nil)(if (sv-bool (not (sv-bool sv-num_of_tests_planned))) (progn (mp-Main::sv-say (list (concatenate 'string (sv-string "1..") (sv-string sv-num_of_tests_run))))) nil)(if (sv-bool (not (sv-eq-int sv-num_of_tests_planned sv-num_of_tests_run))) (progn (mp-Main::sv-say (list (concatenate 'string (sv-string "# Looks like you planned ") (sv-string (concatenate 'string (sv-string sv-num_of_tests_planned) (sv-string (concatenate 'string (sv-string " tests, but ran ") (sv-string sv-num_of_tests_run))))))))) nil)(if (sv-bool sv-num_of_tests_failed) (progn (mp-Main::sv-say (list (concatenate 'string (sv-string "# Looks like you failed ") (sv-string (concatenate 'string (sv-string sv-num_of_tests_failed) (sv-string (concatenate 'string (sv-string " tests of ") (sv-string sv-num_of_tests_run))))))))) nil)(setf sv-num_of_tests_run 0)(setf sv-num_of_tests_failed 0)(setf sv-num_of_tests_planned 0)(setf sv-testing_started 0))))

(in-package mp-Main)
(defmethod sv-perl ((self mp-Test))
  (mp-Main::sv-lisp_dump_object "::Test" (list )))

)


