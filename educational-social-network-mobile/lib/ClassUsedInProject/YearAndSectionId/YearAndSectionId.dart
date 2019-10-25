import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


List<int> yearsId = [26,27,28,29];

List<int> firstYearSectionsId = [2,3,4,5];
List<int> secondYearSectionsId = [6,7,8,9];
List<int> thirdYearSectionsId = [10,11,12,13,14,15,16,17];
List<int> forthYearSectionsId = [18,19,20,21,22,23,24,25];



int getIdByYearAndSectionId(int sectionId){

  if(sectionId == firstYearSectionsId[0] || sectionId == firstYearSectionsId[1] ||
      sectionId == firstYearSectionsId[2] || sectionId == firstYearSectionsId[3]){
    return yearsId[0];
  }
  else if(sectionId == secondYearSectionsId[0] || sectionId == secondYearSectionsId[1] ||
      sectionId == secondYearSectionsId[2] || sectionId == secondYearSectionsId[3]){
    return yearsId[1];
  }
  else if(sectionId == thirdYearSectionsId[0] || sectionId == thirdYearSectionsId[1] ||
      sectionId == thirdYearSectionsId[2] || sectionId == thirdYearSectionsId[3] ||
      sectionId == thirdYearSectionsId[4] || sectionId == thirdYearSectionsId[5] ||
      sectionId == thirdYearSectionsId[6] || sectionId == thirdYearSectionsId[7]){
    return yearsId[2];
  }
  else if(sectionId == forthYearSectionsId[0] || sectionId == forthYearSectionsId[1] ||
      sectionId == forthYearSectionsId[2] || sectionId == forthYearSectionsId[3] ||
      sectionId == forthYearSectionsId[4] || sectionId == forthYearSectionsId[5] ||
      sectionId == forthYearSectionsId[6] || sectionId == forthYearSectionsId[7]){
    return yearsId[3];
  }
  else return 0;
}



