import 'package:ayamutty/end-points/lead-endpoints/lead-endpoints.dart';
import 'package:http/http.dart' as http;

import '../../../end-points/api-contant.dart';
class ListRepository{
  getAllLeads()async{
    print("object");
    try{
      var url=Uri.parse(ApiConstants.baseUrl+LeadEndPoints.get_leads);
      var response=await http.get(url);
      if(response.statusCode==200){
       print(response.body);
      }
      else if(response.statusCode==401){

      }
    }
    catch (e){
      // showSnackBar(context, e.toString());
    }
  }
}