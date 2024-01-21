import requests
from .api_key import api_key
import csv
# pip install googletrans==4.0.0-rc1
from googletrans import Translator
import requests

def translate_text(text, destination_language):
    translator = Translator()
    translation = translator.translate(text, dest=destination_language)
    return translation.text

def     get_local_businesses_gmaps(api_key, latitude, longitude, radius=10000, keyword=None, language='en'):
    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    
    params = {
        'location': f'{latitude},{longitude}',
        'radius': radius,
        'key': api_key,
        'keyword': keyword
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    if 'results' in data:
        response_data = []
        for idx,place in enumerate(data['results']):
            if idx>=7:
                place_id = place['place_id']
                
                # Fetch details for each place
                details_url = "https://maps.googleapis.com/maps/api/place/details/json"
                details_params = {
                    'place_id': place_id,
                    'key': api_key,
                    'fields': 'name,formatted_address,formatted_phone_number,url,types,business_status'
                }

                details_response = requests.get(details_url, params=details_params)
                details_data = details_response.json()

                if 'result' in details_data:
                    result = details_data['result']
                    name = translate_text(result['name'], language)
                    address = translate_text(result.get('formatted_address', 'N/A'), language)
                    phone_number = result.get('formatted_phone_number', 'N/A')
                    business_url = result.get('url', 'N/A')
                    amenities = result.get('types', [])
                    business_status = result.get('business_status', 'N/A')

                    response_data.append({
                        'name': name,
                        'address': address,
                        'phone': phone_number,
                        'url': business_url,
                        'amenities': amenities,
                        'business_status': business_status
                    })

        return response_data
    else:
        print('No results found.')
    


def search_nearby_businesses(api_key, latitude, longitude, keyword, radius=10000, target_language='en'):
    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    location = f"{latitude},{longitude}"

    params = {
        'location': location,
        'radius': radius,
        'keyword': keyword,
        'key': api_key
    }

    response = requests.get(base_url, params=params)
    data = response.json()
    real_data = []

    if response.status_code == 200 and data['status'] == 'OK':
        results = data.get('results', [])
        if not results:
            print(f'No {keyword}s found nearby.')
        else:
            print(f'{keyword}s nearby:')
            for idx,place in enumerate(results):
                if idx > 7:
                    name = place.get('name', 'N/A')
                    address = place.get('vicinity', 'N/A')

                    # Translate name and address
                    translated_name = translate_text(name, target_language)
                    translated_address = translate_text(address, target_language)

                    place_id = place.get('place_id')

                    # Fetch details for each place
                    details_url = "https://maps.googleapis.com/maps/api/place/details/json"
                    details_params = {
                        'place_id': place_id,
                        'key': api_key
                    }
                    details_response = requests.get(details_url, params=details_params)
                    details_data = details_response.json()

                    if details_response.status_code == 200 and details_data['status'] == 'OK':
                        phone_number = details_data['result'].get('formatted_phone_number', 'N/A')
                        business_url = details_data['result'].get('url', 'N/A')

                        # Fetch photos for each place if available
                        photos = details_data['result'].get('photos', [])
                        if photos:
                            photo_reference = photos[0].get('photo_reference', '')
                            photos_url = "https://maps.googleapis.com/maps/api/place/photo"
                            photos_params = {
                                'maxwidth': 400,  # Adjust as needed
                                'photoreference': photo_reference,
                                'key': api_key
                            }
                            photos_response = requests.get(photos_url, params=photos_params)

                            if photos_response.status_code == 200:
                                photo_url = photos_response.url
                            else:
                                photo_url = 'N/A'
                        else:
                            photo_url = 'N/A'

                        real_data.append({'name': translated_name, 'address': translated_address, 'phone': phone_number, 'url': business_url, 'photo_url': photo_url})

                    else:
                        print(f'Error fetching details for {name}')
            return real_data
    else:
        print(response.json())
        return {'message': f'Error fetching {keyword}s'}


if __name__ == '__main__':
    print(get_local_businesses_gmaps(api_key,12.335724, 76.619575))


def get_data_based_user_query(latitude:str, longitude:str,query,lang='en'):
    if latitude and longitude and query:
        return search_nearby_businesses_query(api_key,(latitude,longitude),query,language=lang)
    else:
        return {'message':'data was not provided'}

def get_all_data(latitude:str, longitude:str,radius,language):
    if latitude and longitude:
        return get_local_businesses_gmaps(api_key,latitude,longitude,radius,language=language)
    else:
        return {'message':'data was not provided'}


def get_amenity_data(latitude:str,longitude:str,amenity:str,radius,language='en'):
    if latitude and longitude and amenity:
        return search_nearby_businesses(api_key,latitude,longitude,radius=radius,keyword=amenity,target_language=language)
    return {'message':'get_amenity_data'}


def search_nearby_businesses_query(api_key, location, query, radius=1000,language='en'):
    base_url = "https://maps.googleapis.com/maps/api/place/textsearch/json"
    
    params = {
        'location': f'{location[0]},{location[1]}',
        'radius': radius,
        'key': api_key,
        'query': query
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    if 'results' in data:
        data_response=[]
        for idx,place in enumerate(data['results']):
            if idx>=7:
                place_id = place['place_id']
                
                # Fetch details for each place
                details_url = "https://maps.googleapis.com/maps/api/place/details/json"
                details_params = {
                    'place_id': place_id,
                    'key': api_key,
                    'fields': 'name,formatted_address,formatted_phone_number,url,types,business_status'
                }

                details_response = requests.get(details_url, params=details_params)
                details_data = details_response.json()

                if 'result' in details_data:
                    result = details_data['result']
                    name = result['name']
                    address = result.get('formatted_address', 'N/A')
                    phone_number = result.get('formatted_phone_number', 'N/A')
                    business_url = result.get('url', 'N/A')

                    data_response.append({'name':name,'address':address,'phone':phone_number,'url':business_url})
        return data_response

    else:
        print('No results found.')

def get_government_scheme():
    dict_list = []

    with open('govt_business.csv', 'r', newline='',encoding='utf-8-sig') as csv_file:
        reader = csv.DictReader(csv_file)
        
        for row in reader:
            dict_list.append(dict(row))

    print(dict_list)

    return dict_list