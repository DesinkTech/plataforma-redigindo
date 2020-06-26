## CHANGELOG - Plataforma Redigindo

#### v0.1.1 - 09/06/2020:
##### Fixed
- 'New Admin' form missing 'username' field;

#### v0.1.2 - 10/06/2020:
##### Fixed
-  'User ID' instead of 'Admin'/'Reviewer' ID being put in 'Corrections';

#### v0.1.3 - 11/06/2020:
##### Fixed
- Wrong data being displayed in "Redações corrigidas" at 'Admin/Home' view;
- Included script to show tooltips at 'Correction's layout;
- Wrong layout position at 'Correction' validation;

##### Added

- 'Recorte de Texto' field included at 'Correction Comments';

##### Changed

- 'Correction' layout;

#### v0.2.0 - 17/06/2020:
##### Fixed

- Modal showing only one file in 'Essays' index;
- Not firing 'CorrectionComments' exclusion after 'Correction' exclusion;
- Missing 'Turma' info in 'Student' visualization;
- Trying to show a _Nil_ file in 'Themes' without attachment;

##### Added

- 'Classrooms' to contain 'Students';
- Attach files to 'Themes';
- Image compression and normalization on 'Essays' uploaded files;
- 'Extended Comment' field added in 'Correction Comments';
- 'Correction' canceling;
- Image Zoom in/out and rotation in 'Corrections';
- Image annotation in 'Corrections;'
- Instructions to send an essay;
- Attach files to 'Classrooms';

##### Changed

- Changed '_per_page_' number of 25 to 16;
- Changed color and border-width of selected input in 'Login' layout; 
- Removed 'Essay Line', 'Penalty' and 'Text Cut' fields from 'Correction Comments';
- Moved correction's 'Final Score' calculation to the correction finish;
- Removed 'RG' from 'User';
- Disable 'Comments';
- Sort 'Themes' by 'Categories';

#### v0.2.1 - 25/06/2020:
##### Fixed

- Order of migration;

#### v0.2.2 - 25/06/2020:
##### Fixed

- 'Text_cut' column being removed without exists;

#### v0.2.3 - 26/06/2020:
##### Fixed

- Inexistent column 'essay_line' in 'Correction' start;
- Trying to show a _Nil_ file in 'Essay' submission without attachment;
- All 'Themes' showing to the 'Student' in essay submission;
 
#### v0.2.4 - 26/06/2020:
##### Fixed

- 'fill_themes' method being called in all other 'Essay' controller methods;

#### v0.2.5 - 26/06/2020:
##### Fixed

- 'comment_id' parameter being send to a _Nil_ column in 'CorrectionComment' model;

#### Added

- More instructions to send an essay;