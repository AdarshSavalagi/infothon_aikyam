from rest_framework.views import APIView,Response
from .helpers import *

class IndexView(APIView):
    def post(self, request):
        latitude=request.data.get('latitude',None)
        longitude=request.data.get('longitude',None)
        radius=int(request.data.get('radius',10000))
        lang=request.data.get('lang','en')
        if request.data.get('type',0)=='1': 
            '''
            sending data related to the users location based on amenity
            '''
            amenity=request.data.get('amenity')
            return Response(get_amenity_data(latitude,longitude,amenity,radius,lang))
        elif request.data.get('type',0)=='2':
            '''
            sending data based on user query 
            '''
            return Response(get_data_based_user_query(latitude,longitude,request.data.get('query'),lang))
        elif request.data.get('type')=='3':
            '''
            send government scheme 
            '''
            return Response(get_government_scheme())
        return Response(get_all_data(latitude,longitude,radius,language=lang))
    


# class TranslateApi(APIView):
#     def post(self,request):
#         from_lang=request.data.get('from')
#         to_lang=request.data.get('to')
#         query=request.data.get('query')
