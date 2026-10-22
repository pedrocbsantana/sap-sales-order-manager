# Sales Order Manager

A sales order management application built with **SAP ABAP Cloud** and the **ABAP RESTful Application Programming Model (RAP)**.

This project was developed to practice building transactional business applications in SAP, covering data modeling, business behavior, OData service exposure, and integration with SAP Fiori Elements.

## Overview

Sales Order Manager provides a simple interface for creating and managing sales orders.

The application uses a managed RAP business object with draft support, allowing users to create, view, update, and delete orders through a Fiori Elements interface.

It also includes a custom backend validation to prevent orders with invalid amounts from being saved.

### Demo

<!-- Add your demonstration video or GIF here. -->

### Screenshots

<!-- Replace the placeholders below with actual screenshots. -->

**Sales Order List**

<!-- ![Sales Order List](docs/screenshots/order-list.png) -->

**Order Details**

<!-- ![Order Details](docs/screenshots/order-details.png) -->

**Business Validation**

<!-- ![Amount Validation](docs/screenshots/amount-validation.png) -->

## Tech Stack

| Technology         | Purpose                       |
| ------------------ | ----------------------------- |
| ABAP Cloud         | Backend development           |
| ABAP RAP           | Transactional business object |
| ABAP CDS           | Data modeling and projections |
| OData V4           | Service exposure              |
| SAP Fiori Elements | Application interface         |
| Eclipse ADT        | Development environment       |
| abapGit            | Source code version control   |

## Features

### Sales Order Management

The application supports standard CRUD operations:

* **Create:** Register a new sales order.
* **Read:** Display existing orders and their details.
* **Update:** Modify order information.
* **Delete:** Remove an existing order.

Each order contains the following fields:

| Field           | Description                         |
| --------------- | ----------------------------------- |
| Order ID        | Unique order identifier             |
| Customer Name   | Customer associated with the order  |
| Amount          | Order amount                        |
| Currency Code   | Currency associated with the amount |
| Status          | Order status                        |
| Created At      | Creation timestamp                  |
| Last Changed At | Last modification timestamp         |

### Draft Support

The RAP business object uses draft handling.

Users can work with draft instances before activating their changes.

Draft functionality is configured through the behavior definitions and handled by the RAP framework.

### Business Validation

A custom RAP validation ensures that an order amount is greater than zero.

The validation is executed during save processing for both creation and update operations.

If the amount is invalid:

1. The backend identifies the invalid order.
2. The operation is rejected through the RAP `FAILED` response.
3. An error message is returned through `REPORTED`.
4. SAP Fiori Elements displays the validation message to the user.

**Validation rule:**

`Amount > 0`

**Error message:**

`O valor do pedido deve ser maior que zero.`

The validation is implemented in the behavior handler using `READ ENTITIES` to access business object data within the RAP transactional context.

## Architecture

The application follows a layered RAP architecture.

```text
                  SAP Fiori Elements
                          |
                          v
                    OData V4 UI
                          |
                          v
              Service Definition / Binding
                  ZUI_ORDER_JP
                  ZUI_ORDER_O4_JP
                          |
                          v
                 Projection Layer
                   ZC_ORDER_JP
                          |
                          v
                RAP Business Object
                   ZI_ORDER_JP
                          |
                Behavior Definition
                          |
                          v
              Behavior Implementation
                  ZBP_I_ORDER_JP
                          |
                +---------+---------+
                |                   |
                v                   v
          Active Table         Draft Table
           ZORDER_JP           ZORDER_D_JP
```

### Data Layer

**`ZORDER_JP`**

The persistent database table stores active sales order records.

**`ZORDER_D_JP`**

The draft table supports temporary draft instances managed by the RAP framework.

### CDS Layer

**`ZI_ORDER_JP` — Interface View**

Defines the root business entity based on the persistent table.

**`ZC_ORDER_JP` — Projection View**

Exposes the fields required by the application and includes UI annotations used by SAP Fiori Elements.

### Behavior Layer

**`ZI_ORDER_JP` — Behavior Definition**

Defines the transactional capabilities of the business object, including:

* Create, update, and delete operations
* Draft handling
* Field properties
* Entity-to-table field mapping
* Amount validation

**`ZBP_I_ORDER_JP` — Behavior Implementation**

Contains the custom ABAP validation logic.

The RAP framework handles the standard managed persistence operations.

### Service Layer

**`ZUI_ORDER_JP` — Service Definition**

Exposes the projection entity as `Orders`.

**`ZUI_ORDER_O4_JP` — Service Binding**

Publishes the application through OData V4 UI.

## Implementation Details

### Managed RAP

The project uses a managed RAP implementation.

Standard persistence operations are handled by the RAP framework, while custom business logic is implemented in the behavior handler.

This separation allows the application to focus on business rules without manually implementing standard database CRUD operations.

### Entity Manipulation Language

The validation uses RAP Entity Manipulation Language (EML) to retrieve order data:

```abap
READ ENTITIES OF zi_order_jp IN LOCAL MODE
  ENTITY Order
  FIELDS ( Amount )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_orders).
```

This reads the relevant business entity data from the RAP transactional context.

The validation then checks each returned order and reports invalid amounts.

### Fiori Elements

The user interface is generated using SAP Fiori Elements.

CDS UI annotations define the presentation of fields in the list report and object page.

No custom SAPUI5 frontend was developed for this project.

## Running the Application

This application requires access to a compatible SAP ABAP environment supporting RAP and OData V4.

It cannot be executed as a standalone local application.

The project was developed using Eclipse with ABAP Development Tools (ADT).

To explore or deploy the project in a compatible SAP environment:

1. Configure access to the ABAP development system through Eclipse ADT.
2. Import the repository using abapGit.
3. Activate the imported development objects
