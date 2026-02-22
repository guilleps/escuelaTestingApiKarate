@regresion
Feature: Automatizar API PetStore

  Background:
    * url apiPetStore

  @TEST-1
  Scenario: crear mascota

    * def pet = read('classpath:examples/data/crear-mascote.json')

    Given path 'pet'
    And request pet
    When method post
    Then status 200

    And match response.id == 23423
    And match response.name == 'firulais'
    And match response.status == 'available'

    * def id = response.id
    * def name = response.name
    * def status = response.status
    * print 'created pet is: ID=', id, "NAME=", name, "STATUS=", status

  @TEST-2
  Scenario: obtener una mascota por estado
    Given path 'pet/findByStatus'
    And param status = ['available', 'pending', 'sold']
    When method get
    Then status 200
    * def expectedStatuses = ['available', 'pending', 'sold']
    * match each response[*].status == '#? expectedStatuses.includes(_)'

  @TEST-3
  Scenario Outline: Oobtener mascotas por los 3 estados
    Given path 'pet/findByStatus'
    And param status = '<status>'
    When method get
    Then status 200
    And print response
    And match each response[*].status == '<status>'

    Examples:
      | status    |
      | available |
      | sold      |
      | pending   |


  @TEST-4
  Scenario Outline: obtener mascota por id

    Given path 'pet', <petId>
    When method get
    Then status 200
    And match response.id == <petId>
    And print response

    Examples:
      | petId |
      | 23423 |
#      | 3     |
#      | 5     |

  @TEST-5
  Scenario: Subir una imagen para una mascota existente
    * def petId = 23423

    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'perrito.jpg', filename: 'perrito.jpg', contentType: 'image/jpeg' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 200
    And match response.message contains 'perrito.jpg'

#  @TEST-6
#  Scenario Outline: eliminar mascota por id
#
#    Given path 'pet', <petId>
#    When method delete
#    Then status 200
#    And match response.id == <petId>
#    And print response
#
#    Examples:
#      | petId |
#      | 1     |
#      | 3     |
#      | 5     |